import XCTest
@testable import Sessions
import Core
import Node
import Cache

class SessionsTests: XCTestCase {
    static let allTests = [
        ("testMemory", testMemory),
        ("testCache", testCache),
    ]

    func testMemory() throws {
        let s = MemorySessions()
        let id = s.makeIdentifier()

        XCTAssertNil(s.get(for: id))

        s.set(Node("bar"), for: id)
        XCTAssertEqual(s.get(for: id)?.string, "bar")

        s.destroy(id)
        XCTAssertNil(s.get(for: id))
    }

    func testCache() throws {
        let m = MemoryCache()
        let s = CacheSessions(cache: m)
        let id = s.makeIdentifier()

        XCTAssertNil(try s.get(for: id))

        try s.set(Node("bar"), for: id)
        XCTAssertEqual(try s.get(for: id)?.string, "bar")

        try s.destroy(id)
        XCTAssertNil(try s.get(for: id))
    }
    
}
