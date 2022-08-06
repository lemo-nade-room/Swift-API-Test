import Vapor
import XCTest

extension URLResponse {
    
    func assert(_ status: HTTPStatus) {
        guard let actual = (self as? HTTPURLResponse)?.statusCode else {
            XCTFail("response has not status code")
            return
        }
        XCTAssertEqual(Int(status.code), actual)
    }
}
