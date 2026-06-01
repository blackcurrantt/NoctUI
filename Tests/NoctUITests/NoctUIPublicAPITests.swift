import SwiftUI
import XCTest
import NoctUI

final class NoctUIPublicAPITests: XCTestCase {
    func testCustomBuildingBlocksCanBeConstructed() {
        let radius = NoctRadius(sm: 6, md: 10, lg: 14)
        let shadow = NoctShadow(
            color: .black.opacity(0.2),
            radius: 10,
            x: 0,
            y: 4
        )
        let colors = NoctChipColor(
            normal: .gray,
            selected: .blue
        )
        let chipStyle = NoctChipCustomStyle(
            backgroundColor: colors,
            borderColor: colors,
            borderWidth: 1,
            textColor: colors
        )
        let icons = NoctIconProvider { token in
            token == .success ? .asset("success") : nil
        }

        XCTAssertEqual(radius.sm, 6)
        XCTAssertEqual(radius.md, 10)
        XCTAssertEqual(radius.lg, 14)
        XCTAssertEqual(shadow.radius, 10)
        XCTAssertEqual(shadow.x, 0)
        XCTAssertEqual(shadow.y, 4)
        XCTAssertEqual(chipStyle.borderWidth, 1)
        XCTAssertEqual(icons.icon(for: .success), .asset("success"))
        XCTAssertEqual(
            icons.icon(for: .warning),
            .system("exclamationmark.triangle.fill")
        )

        _ = BrandTheme()
        _ = NoctChip(title: "SwiftUI", style: .custom(chipStyle)) {}
        _ = NoctCard(radius: radius.md, shadow: shadow) {
            Text("Account")
        }
    }
}

private struct BrandTheme: NoctTheme {
    var primary: Color { Color(hex: 0x7C3AED) }
    var radius: NoctRadius { NoctRadius(sm: 6, md: 10, lg: 14) }
    var buttonShape: NoctShape { .pill }
}
