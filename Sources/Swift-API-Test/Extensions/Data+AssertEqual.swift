import Vapor
import XCTest

extension Data {
    
    func assert<Res: Decodable & Equatable>(_ expected: Res) throws {
        if Res.self == String.self {
            stringAssert(expected as! String)
        } else {
            try objectAssert(expected)
        }
    }
    
    private func stringAssert(_ expected: String) {
        guard let result = String(data: self, encoding: .utf8) else {
            XCTFail()
            return
        }
        XCTAssertEqual(expected, result)
    }
    
    private func objectAssert<Res: Decodable & Equatable>(_ expected: Res) throws {
        let result = try JSONDecoder().decode(Res.self, from: self)
        XCTAssertEqual(result, expected)
    }
}
