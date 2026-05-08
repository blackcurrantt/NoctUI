//
//  NoctIconView.swift
//  NoctUI
//
//  Created by blackcurrantt
//

import SwiftUI

public struct NoctIconView: View {
    @Environment(\.noctIconProvider) private var noctIconProvider
    
    private let icon: NoctIcon
    private let size: NoctIconSize
    private let color: Color
    
    public init(
        _ icon: NoctIcon,
        size: NoctIconSize = .md,
        color: Color = .primary
    ) {
        self.icon = icon
        self.size = size
        self.color = color
    }

    public init(
        _ token: NoctIconToken,
        size: NoctIconSize = .md,
        color: Color = .primary
    ) {
        self.icon = .token(token)
        self.size = size
        self.color = color
    }
    
    @ViewBuilder
    public var body: some View {
        if let image {
            image
                .renderingMode(.template)
                .resizable()
                .scaledToFit()
                .frame(width: size.pointSize, height: size.pointSize)
                .foregroundStyle(color)
        }
    }
    
    private var image: Image? {
        guard let icon = resolvedIcon else { return nil }
        
        switch icon {
        case let .system(name):
            return Image(systemName: name)
        case let .asset(name):
            return Image(name)
        case .token:
            return nil
        }
    }
}

// MARK: - Icon

private extension NoctIconView {
    var resolvedIcon: NoctIcon? {
        resolve(icon, depth: 0)
    }
    
    func resolve(_ icon: NoctIcon, depth: Int) -> NoctIcon? {
        guard depth < 8 else { return nil }
        
        switch icon {
        case .system, .asset:
            return icon
        case let .token(token):
            guard let providedIcon = noctIconProvider.icon(for: token) else { return nil }
            return resolve(providedIcon, depth: depth + 1)
        }
    }
}
