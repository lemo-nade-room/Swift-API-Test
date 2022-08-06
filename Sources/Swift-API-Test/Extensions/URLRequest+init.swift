import Vapor
import XCTest

extension URLRequest {
    init?(url: URL, method: HTTPMethod){
        self.init(url: url)
        self.httpMethod = method.rawValue
    }
}
