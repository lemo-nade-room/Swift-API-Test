import Vapor
import XCTest

extension URLRequest {
    init?(url: String, method: HTTPMethod){
        guard let url = URL(string: url) else {
            return nil
        }
        self.init(url: url)
        self.httpMethod = method.rawValue
    }
}
