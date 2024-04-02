@testable import DevToolCore
import XCTest

final class DevToolTests: XCTestCase {
    func testIfEmpty() throws {
        XCTAssertEqual([].ifEmpty(others: [1, 2, 3]), [1, 2, 3])
        XCTAssertEqual([1].ifEmpty(others: [1, 2, 3]), [1])
    }

    func testRemoveDuplicates() throws {
        let a = [1, 1, 2, 3, 3, 4, 5, 5]
        let b = a
        let c = b.removeDuplicates()

        XCTAssertEqual(a, b)
        XCTAssertNotEqual(b, [1, 2, 3, 4, 5])
        XCTAssertEqual(c, [1, 2, 3, 4, 5])
    }
}
