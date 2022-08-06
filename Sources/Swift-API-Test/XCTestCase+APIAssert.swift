import XCTest
import Vapor

public extension XCTestCase {
    /** The HTTP Request of This API Test does NOT has Parameter */
    func APIAssert<Res: Decodable & Equatable>(
        url: String,
        method: HTTPMethod = .GET,
        expectedHTTPStatus: HTTPStatus = .ok,
        expected: Res
    ) async throws {
        guard let request = URLRequest(url: url, method: method) else {
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
        guard let request = URLRequest(url: url, method: method) else {
            XCTFail()
            return
        }
        let (data, response) = try await request.request(parameter)
        response.assert(expectedHTTPStatus)
        try data.assert(expected)
    }
}
