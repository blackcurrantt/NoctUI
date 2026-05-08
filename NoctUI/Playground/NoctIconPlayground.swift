//
//  NoctIconPlayground.swift
//  NoctUI
//
//  Created by blackcurrantt
//

import SwiftUI

struct NoctIconPlayground: View {
    @Environment(\.noctTheme) private var noctTheme
    
    private struct Section: Hashable {
        let id = UUID()
        let title: String
        let tokens: [NoctIconToken]
        
        init(_ title: String, _ tokens: [NoctIconToken]) {
            self.title = title
            self.tokens = tokens
        }
    }
    
    private let sections: [Section] = [
        Section("Custom", [
            .email, .notification, .search
        ]),
        Section("Semantic", [
            .success, .warning, .error, .info
        ]),
        Section("Utility", [
            .close, .clear, .eye, .eyeOff
        ]),
        Section("Navigation", [
            .chevronUp, .chevronDown, .chevronLeft, .chevronRight
        ])
    ]
    
    private enum Size: CaseIterable, Equatable {
        case xs, sm, md, lg, xl, s40px
        
        var noct: NoctIconSize {
            switch self {
            case .xs: .xs
            case .sm: .sm
            case .md: .md
            case .lg: .lg
            case .xl: .xl
            case .s40px: .custom(40)
            }
        }
    }
    @State private var selectedSize: Size = .xl
    
    private enum ColorOption: CaseIterable, Equatable {
        case primary, secondary
    }
    @State private var selectedColor: ColorOption = .primary
    var noctColor: Color {
        switch selectedColor {
        case .primary:
            return noctTheme.primary
        case .secondary:
            return noctTheme.secondary
        }
    }

    private let columns = Array(repeating: GridItem(.flexible(), spacing: 16), count: 3)

    var body: some View {
        PlaygroundView(height: 60) {
            VStack(spacing: 12) {
                PlaygroundPicker($selectedSize)
                PlaygroundPicker($selectedColor)
            }
            .padding(.horizontal, 16)
        } config: {
            VStack(alignment: .leading, spacing: 24) {
                ForEach(sections, id: \.self) { section in
                    PlaygroundSection(section.title) {
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(section.tokens, id: \.self) { token in
                                NoctCard(padding: .init(top: 16, leading: 8, bottom: 16, trailing: 8)) {
                                    VStack {
                                        Spacer()
                                        NoctIconView(NoctIcon(token), size: selectedSize.noct, color: noctColor)
                                        Spacer()
                                        Text(token.rawValue)
                                            .noctTextStyle(.body(.sm))
                                            .lineLimit(1)
                                    }
                                    .frame(height: 78)
                                    .frame(maxWidth: .infinity)
                                }
                            }
                        }
                    }
                }
            }
            .padding()
        }
        .noctIconProvider(.custom)
    }
}

private extension NoctIconToken {
    static let email = NoctIconToken("email")
    static let notification = NoctIconToken("notification")
    static let search = NoctIconToken("search")
}

private extension NoctIconProvider {
    static let custom = NoctIconProvider { token in
        switch token {
        case .email: .system("envelope")
        case .notification: .system("bell.fill")
        case .search: .system("magnifyingglass")
        default: nil
        }
    }
}

#Preview {
    NoctIconPlayground()
}
