import XCTest

public func motoSwiftTests() {
   testModelParser()
   testRenderer()
#if TEST_MODEL
   testGeneratedCode()
#endif
}

class MotoSwiftTests: XCTestCase {
   func testRunMotoSwiftTests() {
      motoSwiftTests()
   }
}
