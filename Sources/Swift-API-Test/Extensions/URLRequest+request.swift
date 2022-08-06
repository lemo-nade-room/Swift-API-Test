import Vapor

extension URLRequest {
    
    func request() async throws -> (Data, URLResponse) {
        return try await URLSession.shared.data(for: self)
    }
    
    func request<Param: Encodable>(_ parameter: Param) async throws -> (Data, URLResponse) {
        var req = self
        req.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let payload = try JSONEncoder().encode(parameter)
        return try await URLSession.shared.upload(for: req, from: payload)
    }
}
