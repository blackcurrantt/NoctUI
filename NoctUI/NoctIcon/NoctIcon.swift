//
//  NoctIcon.swift
//  NoctUI
//
//  Created by blackcurrantt
//

import SwiftUI

public struct NoctIcon: View {
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
            .font(.system(size: size.pointSize, weight: .semibold))
            .foregroundStyle(color ?? .primary)
    }
}

public enum NoctIconSize {
    case sm, md, lg, xl
    
    var pointSize: CGFloat {
        switch self {
        case .sm: 12
        case .md: 14
        case .lg: 16
        case .xl: 20
        }
    }
}
