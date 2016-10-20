EXECUTABLE_NAME=motoswift

BUNDLE_PATH=./motoswift
BUNDLE_TEMPLATES_PATH=$(BUNDLE_PATH)/templates
BUNDLE_BIN_PATH=$(BUNDLE_PATH)/bin
BUNDLE_LIB_PATH=$(BUNDLE_PATH)/lib

BUILD_CONFIGURATION=release
BUILD_PATH=./.build/$(BUILD_CONFIGURATION)/$(EXECUTABLE_NAME)

DEFAULT_RPATH=$(shell dirname $(shell dirname $(shell xcrun -find swift-stdlib-tool)))/lib/swift/macosx
RPATH=@executable_path/../lib

TEMPORARY_FOLDER=/tmp/MotoSwift.dst
FRAMEWORKS_FOLDER=/Library/Frameworks
BINARIES_FOLDER=/usr/local/bin

OUTPUT_PACKAGE=MotoSwift.pkg

VERSION_STRING=$(shell agvtool what-marketing-version -terse1)

HOME_PATH=$(shell pwd)
TEST_RESOURCES_PATH=$(HOME_PATH)/Tests/MotoSwiftFrameworkTests/Resources

MOMC_PATH=$(shell dirname $(shell xcrun -find momc))

lint:
	swiftlint lint --path ./Source

build:
	swift build --configuration $(BUILD_CONFIGURATION)

.prepare_test_data: build
	"$(BUILD_PATH)" entity --model $(TEST_RESOURCES_PATH)/TypesModel.xcdatamodeld --template ./Templates/class.stencil --output ./Tests/MotoSwiftFrameworkTests/Generated --rewrite --file-mask "{{class}}+CoreDataClass.swift"
	"$(BUILD_PATH)"  entity --model $(TEST_RESOURCES_PATH)/TypesModel.xcdatamodeld --template ./Templates/properties.stencil --output ./Tests/MotoSwiftFrameworkTests/Generated --rewrite --file-mask "{{class}}+CoreDataProperties.swift"
	cd "$(MOMC_PATH)"; xcrun momc $(TEST_RESOURCES_PATH)/TypesModel.xcdatamodeld $(TEST_RESOURCES_PATH)/TypesModel.momd

test: .prepare_test_data
	swift test -Xswiftc -DTEST_MODEL
	rm -rf $(TEST_RESOURCES_PATH)/TypesModel.momd

.bundle_binary: build
	mkdir -p "$(BUNDLE_BIN_PATH)"
	cp "$(BUILD_PATH)" "$(BUNDLE_BIN_PATH)"
	install_name_tool -delete_rpath "$(DEFAULT_RPATH)" "$(BUNDLE_BIN_PATH)/$(EXECUTABLE_NAME)" | true
	install_name_tool -add_rpath "$(RPATH)" "$(BUNDLE_BIN_PATH)/$(EXECUTABLE_NAME)"

.bundle_templates:
	mkdir -p "$(BUNDLE_TEMPLATES_PATH)"
	cp -r ./Templates/* "$(BUNDLE_TEMPLATES_PATH)"

.bundle_libraries:
	mkdir -p "$(BUNDLE_LIB_PATH)"
	xcrun swift-stdlib-tool --copy --verbose --Xcodesign --timestamp=none \
		--scan-executable "$(BUILD_PATH)" \
		--platform macosx --destination "$(BUNDLE_LIB_PATH)" \
		--strip-bitcode

bundle: .bundle_binary .bundle_libraries .bundle_templates

.package: export BUNDLE_BIN_PATH=$(TEMPORARY_FOLDER)$(BINARIES_FOLDER)
.package: export BUNDLE_LIB_PATH=$(TEMPORARY_FOLDER)$(FRAMEWORKS_FOLDER)/MotoSwift
.package: export RPATH=$(FRAMEWORKS_FOLDER)/MotoSwift

.package: .bundle_binary .bundle_libraries
	pkgbuild \
		--identifier "com.igorpalaguta.motoswift" \
		--install-location "/" \
		--root "$(TEMPORARY_FOLDER)" \
		--version "$(VERSION_STRING)" \
		"$(OUTPUT_PACKAGE)"

install: .package
	sudo installer -pkg "$(OUTPUT_PACKAGE)" -target /

uninstall:
	rm -rf "$(FRAMEWORKS_FOLDER)/MotoSwift"
	rm -f "$(BINARIES_FOLDER)/motoswift"

clean:
	rm -f "$(OUTPUT_PACKAGE)"
	rm -rf "$(TEMPORARY_FOLDER)"
	rm -rf "$(BUNDLE_PATH)"
	swift build --clean
