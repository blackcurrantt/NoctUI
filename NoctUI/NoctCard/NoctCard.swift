//
//  NoctCard.swift
//  NoctUI
//
//  Created by blackcurrantt
//

import SwiftUI

public struct NoctCard<Content: View>: View {
    @Environment(\.noctTheme) private var noctTheme
    
    private let padding: EdgeInsets
    private let cornerRadius: CGFloat
    private let background: Color?
    private let border: CGFloat?
    private let borderColor: Color?
    private let shadow: NoctShadow?
    private let content: Content
    
    // MARK: - Init
    public init(
        padding: EdgeInsets = .all(16),
        cornerRadius: CGFloat = NoctRadius.lg,
        background: Color? = nil,
        border: CGFloat? = nil,
        borderColor: Color? = nil,
        shadow: NoctShadow? = NoctShadow.card,
        @ViewBuilder content: () -> Content
    ) {
        self.padding = padding
        self.cornerRadius = cornerRadius
        self.background = background
        self.border = border
        self.borderColor = borderColor
        self.shadow = shadow
        self.content = content()
    }
    
    // MARK: - Body
    public var body: some View {
        content
            .padding(padding)
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(background ?? noctTheme.card)
            )
            .overlay(
                Group {
                    if let border {
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .stroke(borderColor ?? noctTheme.border, lineWidth: border)
                    }
                }
            )
            .cornerRadius(cornerRadius)
            .noctShadow(shadow)
            .contentShape(Rectangle())
    }
}


