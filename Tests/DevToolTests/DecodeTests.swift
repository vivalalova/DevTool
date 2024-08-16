@testable import DevToolCore
import XCTest

final class DecodeTests: XCTestCase {
    struct OO: Codable {
        var a: Int
        var b: String
    }

    func testString() throws {
        let string = """
        {"a":1,"b":"2"}
        """

        let oo: OO? = string.decode()

        if let data = string.data(using: .utf8) {
            let bc = try? JSONDecoder().decode(OO.self, from: data)

            XCTAssertEqual(bc?.a, 1)
            XCTAssertEqual(bc?.b, "2")
        }

        let bb = try? JSONDecoder().decode(OO.self, from: string)
        print("ooo", oo)

        XCTAssertEqual(oo?.a, 1)
        XCTAssertEqual(oo?.b, "2")
    }

//    func testData() throws {
//        let oo: OO? = """
//        {"a":1,"b":"2"}
//        """
//        .data(using: .utf8)
//        .decode()
//
//        XCTAssert(oo?.a == 1 && oo?.b == "2")
//    }
}
