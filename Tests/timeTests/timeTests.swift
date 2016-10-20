import XCTest
@testable import time

class timeTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(time().text, "Hello, World!")
    }


    static var allTests : [(String, (timeTests) -> () throws -> Void)] {
        return [
            ("testExample", testExample),
        ]
    }
}
