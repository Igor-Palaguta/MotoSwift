EXECUTABLE_NAME=motoswift

BUNDLE_PATH=./motoswift
BUNDLE_TEMPLATES_PATH=$(BUNDLE_PATH)/templates
BUNDLE_BIN_PATH=$(BUNDLE_PATH)/bin
BUNDLE_LIB_PATH=$(BUNDLE_PATH)/lib

SPM_RELEASE_DIR=./.build/release
RELEASE_BUILD_PATH=$(SPM_RELEASE_DIR)/$(EXECUTABLE_NAME)

DEFAULT_RPATH=`dirname \`dirname \\\`xcrun -find swift-stdlib-tool\\\`\``/lib/swift/macosx

build:
	swift build --configuration release

test:
	swift test

.bundle_binary: build
	mkdir -p $(BUNDLE_BIN_PATH)
	cp $(RELEASE_BUILD_PATH) $(BUNDLE_BIN_PATH)
	install_name_tool -delete_rpath $(DEFAULT_RPATH) $(BUNDLE_BIN_PATH)/$(EXECUTABLE_NAME) | true
	install_name_tool -add_rpath "@executable_path/../lib" $(BUNDLE_BIN_PATH)/$(EXECUTABLE_NAME)

.bundle_templates:
	mkdir -p $(BUNDLE_TEMPLATES_PATH)
	cp -r ./Templates/* $(BUNDLE_TEMPLATES_PATH)

.bundle_libraries:
	mkdir -p $(BUNDLE_LIB_PATH)
	xcrun swift-stdlib-tool --copy --verbose --Xcodesign --timestamp=none \
		--scan-executable $(RELEASE_BUILD_PATH) \
		--platform macosx --destination $(BUNDLE_LIB_PATH) \
		--strip-bitcode

bundle: .bundle_binary .bundle_templates .bundle_libraries
