import XCTest

public func motoSwiftTests() {
   testModelParser()
#if TEST_MODEL
   testGeneratedCode()
#endif
}

class MotoSwiftTests: XCTestCase {
   func testRunMotoSwiftTests() {
      motoSwiftTests()
   }
}
