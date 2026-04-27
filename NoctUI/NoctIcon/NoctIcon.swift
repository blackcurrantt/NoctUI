//
//  NoctIcon.swift
//  NoctUI
//
//  Created by blackcurrantt
//

import SwiftUI

public struct NoctIcon: View {
    @Environment(\.noctTheme) private var noctTheme
    
    let name: String
    let size: NoctIconSize
    let color: Color?
    
    public init(
        _ name: String,
        size: NoctIconSize = .md,
        color: Color? = nil
    ) {
        self.name = name
        self.size = size
        self.color = color
    }
    
    public var body: some View {
        Image(systemName: name)
            .font(size.font)
            .foregroundStyle(color ?? noctTheme.primary)
    }
}

public enum NoctIconSize {
    case sm, md, lg
    
    var font: Font {
        switch self {
        case .sm: .footnote
        case .md: .subheadline
        case .lg: .body
        }
    }
}
