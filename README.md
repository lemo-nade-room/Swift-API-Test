# Swift-API-Test

## Overview
This package is to test REST API Server


## Usage

at Package.swift

```swift
import PackageDescription

let package = Package(
    ...
    platforms: [
        .macOS(.v12)
    ],
    dependencies: [
        ...
        .package(url: "https://github.com/lemo-nade-room/Swift-API-Test.git", from: "1.0.0"), // add
    ],
    targets: [
        .testTarget(name: "...Tests", dependencies: [
            ...
            "Swift-API-Test" // add
        ])
    ]
)
```


Test File
```swift
import XCTest
import Swift_API_Test

final class ApiTests: XCTestCase {
    func testGET() async throws {
        try await APIAssert(url: "http://localhost:8000/hello", expected: "Good Morning!")
    }
    
    func testPOST() async throws {
        try await APIAssert(url: "http://localhost:8000/hello", method: .POST, expected: "Hello, POST!")
    }
    
    func testReceiveObject() async throws {
        struct User: Decodable, Equatable {
            let name: String
            let age: Int
        }
        try await APIAssert(
            url: "http://localhost:8000/object",
            expected: User(name: "hello", age: 10)
        )
    }
    
    func testSendObject() async throws {
        struct Name: Encodable {
            let first: String
            let last: String
        }
        try await APIAssert(
            url: "http://localhost:8000/object",
            method: .PATCH,
            parameter: Name(first: "Tom", last: "Riddle") ,
            expected: "Tom Riddle"
        )
    }
    
    func testReturnStatusCode() async throws {
        try await APIAssert(
            url: "http://localhost:8000/object",
            method: .DELETE,
            expectedHTTPStatus: .noContent,
            expected: ""
        )
    }
}
```
