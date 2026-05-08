//
//  NoctIcon.swift
//  NoctUI
//
//  Created by blackcurrantt
//

import SwiftUI

public struct NoctIcon: View {
    @Environment(\.noctIconProvider) private var noctIconProvider
    
    private let token: NoctIconToken?
    private let explicitContent: NoctIconContent?
    private let size: NoctIconSize
    private let color: Color
    
    public init(
        _ token: NoctIconToken,
        size: NoctIconSize = .md,
        color: Color = .primary
    ) {
        self.token = token
        self.explicitContent = nil
        self.size = size
        self.color = color
    }
    
    public init(
        _ content: NoctIconContent,
        size: NoctIconSize = .md,
        color: Color = .primary
    ) {
        self.token = nil
        self.explicitContent = content
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
        guard let content = resolvedContent else { return nil }
        
        switch content {
        case let .system(name):
            return Image(systemName: name)
        case let .asset(name):
            return Image(name)
        }
    }
}

// MARK: - Content

private extension NoctIcon {
    var resolvedContent: NoctIconContent? {
        if let explicitContent {
            return explicitContent
        }
        
        guard let token else { return nil }
        return noctIconProvider.content(for: token)
    }
}
