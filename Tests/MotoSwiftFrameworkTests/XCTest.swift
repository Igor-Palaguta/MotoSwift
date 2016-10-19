import XCTest

public func motoSwiftTests() {
   testModelParser()
#if !SWIFT_PACKAGE
   testGeneratedCode()
#endif
}

class MotoSwiftTests: XCTestCase {
   func testRunMotoSwiftTests() {
      motoSwiftTests()
   }
}
