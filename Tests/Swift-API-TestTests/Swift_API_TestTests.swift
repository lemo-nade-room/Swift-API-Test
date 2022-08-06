import XCTest
@testable import Swift_API_Test

final class Swift_API_TestTests: XCTestCase {
    
    override func setUp() async throws {
        baseURL = "http://localhost:8000"
    }
    func testRelative() async throws {
        try await APIAssert(url: "/hello", expected: "Good Morning!")
    }
    
    func testFull() async throws {
        try await APIAssert(url: "http://localhost:8000/hello", expected: "Good Morning!")
    }
}
