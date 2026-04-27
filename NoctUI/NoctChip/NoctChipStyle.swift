//
//  NoctChipStyle.swift
//  NoctUI
//
//  Created by blackcurrantt
//

import SwiftUI

public enum NoctChipStyle {
    case filled
    case outlined
    case custom(NoctChipCustomStyle)
}

public struct NoctChipColor {
    public let normal: Color
    public let selected: Color
}

public struct NoctChipCustomStyle {
    public let backgroundColor: NoctChipColor
    public let borderColor: NoctChipColor
    public let borderWidth: CGFloat
    public let textColor: NoctChipColor
    
    public init(
        backgroundColor: NoctChipColor,
        borderColor: NoctChipColor,
        borderWidth: CGFloat,
        textColor: NoctChipColor
    ) {
        self.backgroundColor = backgroundColor
        self.borderColor = borderColor
        self.borderWidth = borderWidth
        self.textColor = textColor
    }
}
