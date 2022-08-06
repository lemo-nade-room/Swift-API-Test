import XCTest
@testable import Swift_API_Test

final class Swift_API_TestTests: XCTestCase {
    func testExample() async throws {
        try await APIAssert(url: "http://localhost:8000/hello", expected: "Good Morning!")
    }
}
