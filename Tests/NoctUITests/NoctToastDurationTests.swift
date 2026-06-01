import XCTest
@testable import NoctUI

final class NoctToastDurationTests: XCTestCase {
    func testPositiveDurationConvertsToNanoseconds() {
        XCTAssertEqual(
            NoctToastDuration.nanoseconds(for: 3.25),
            3_250_000_000
        )
    }

    func testNonPositiveDurationDismissesImmediately() {
        XCTAssertEqual(NoctToastDuration.nanoseconds(for: 0), 0)
        XCTAssertEqual(NoctToastDuration.nanoseconds(for: -1), 0)
    }

    func testNonFiniteDurationDismissesImmediately() {
        XCTAssertEqual(NoctToastDuration.nanoseconds(for: .nan), 0)
        XCTAssertEqual(NoctToastDuration.nanoseconds(for: .infinity), 0)
        XCTAssertEqual(
            NoctToastDuration.nanoseconds(for: -.infinity),
            0
        )
    }

    func testOversizedDurationIsClamped() {
        XCTAssertEqual(
            NoctToastDuration.nanoseconds(for: .greatestFiniteMagnitude),
            NoctToastDuration.maximumNanoseconds
        )
    }
}
