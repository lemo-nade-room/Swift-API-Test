import Vapor
import XCTest

extension URLResponse {
    
    func assert(_ status: HTTPStatus) {
        if isStatus(status) { return }
        XCTFail()
    }
    
    private func isStatus(_ status: HTTPStatus) -> Bool {
        if let actual = (self as? HTTPURLResponse)?.statusCode {
            return actual == Int(status.code)
        }
        return false
    }
}
