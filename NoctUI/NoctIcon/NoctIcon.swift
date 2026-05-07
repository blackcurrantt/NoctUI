//
//  NoctIcon.swift
//  NoctUI
//
//  Created by blackcurrantt
//

import SwiftUI

public struct NoctIcon: View {
    @Environment(\.noctIconSet) private var noctIconSet
    
    let token: NoctIconToken
    let size: NoctIconSize
    let color: Color
    
    public init(
        _ token: NoctIconToken,
        size: NoctIconSize = .md,
        color: Color = .primary
    ) {
        self.token = token
        self.size = size
        self.color = color
    }
    
    public var body: some View {
        image
            .renderingMode(.template)
            .resizable()
            .scaledToFit()
            .frame(width: size.pointSize, height: size.pointSize)
            .foregroundStyle(color)
    }
    
    private var image: Image {
        switch content {
        case let .system(name):
            Image(systemName: name)
        case let .asset(name):
            Image(name)
        }
    }
}

// MARK: - Content

private extension NoctIcon {
    var content: NoctIconContent {
        switch token {
        case .success:
            return noctIconSet.success
        case .warning:
            return noctIconSet.warning
        case .error:
            return noctIconSet.error
        case .info:
            return noctIconSet.info
        case .close:
            return noctIconSet.close    
        case .clear:
            return noctIconSet.clear
        case .filter:
            return noctIconSet.filter
        case .search:
            return noctIconSet.search
        case .email:
            return noctIconSet.email
        case .notification:
            return noctIconSet.notification
        case .chevronRight:
            return noctIconSet.chevronRight
        case let .custom(custom):
            return custom
        }
    }
}
