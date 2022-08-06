import XCTest
import Vapor
import Foundation

public extension XCTestCase {
    
    static var _baseURL: URL?
    
    var baseURL: String {
        set {
            Self._baseURL = URL(string: newValue)
        }
        get {
            Self._baseURL?.path ?? ""
        }
    }
    
    private func requestURL(_ url: String) -> URL {
        if url.first != "/", let url = URL(string: url) {
            return url
        }
        if var baseURL = Self._baseURL {
            baseURL.appendPathComponent(url)
            return baseURL
        }
        XCTFail("Illegual URL")
        preconditionFailure("Illegual URL")
    }
    
    /** The HTTP Request of This API Test does NOT has Parameter */
    func APIAssert<Res: Decodable & Equatable>(
        url: String,
        method: HTTPMethod = .GET,
        expectedHTTPStatus: HTTPStatus = .ok,
        expected: Res
    ) async throws {
        guard let request = URLRequest(url: requestURL(url), method: method) else {
            XCTFail()
            return
        }
        let (data, response) = try await request.request()
        response.assert(expectedHTTPStatus)
        try data.assert(expected)
    }
    
    /** The HTTP Request of This API Test has Parameter */
    func APIAssert<Param: Encodable, Res: Decodable & Equatable>(
        url: String,
        method: HTTPMethod = .GET,
        parameter: Param,
        expectedHTTPStatus: HTTPStatus = .ok,
        expected: Res
    ) async throws {
        guard let request = URLRequest(url: requestURL(url), method: method) else {
            XCTFail()
            return
        }
        let (data, response) = try await request.request(parameter)
        response.assert(expectedHTTPStatus)
        try data.assert(expected)
    }
}
