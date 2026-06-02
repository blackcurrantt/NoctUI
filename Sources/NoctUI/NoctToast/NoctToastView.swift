//
//  NoctToastView.swift
//  NoctUI
//
//  Created by blackcurrantt
//

import SwiftUI

public struct NoctToastView: View {
    @Environment(\.noctTheme) private var noctTheme
    @Environment(\.noctToastPresenter) private var presenter
    
    private let state: NoctToastState
    
    public init(state: NoctToastState) {
        self.state = state
    }
    
    private var alignment: Alignment {
        switch state.position {
        case .top: return .top
        case .bottom: return .bottom
        }
    }
    
    private var edgeInsets: EdgeInsets {
        switch state.position {
        case .top:
            return EdgeInsets(top: 16, leading: 16, bottom: 0, trailing: 16)
        case .bottom:
            return EdgeInsets(top: 0, leading: 16, bottom: 16, trailing: 16)
        }
    }
    
    public var body: some View {
        let colors = resolvedColors
        
        toast(
            background: colors.background,
            foreground: colors.foreground
        )
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: alignment)
            .padding(edgeInsets)
    }
    
    private var resolvedColors: (background: Color, foreground: Color) {
        (
            background: state.background ?? state.backgroundProvider?(noctTheme) ?? noctTheme.toast,
            foreground: state.foreground ?? state.foregroundProvider?(noctTheme) ?? noctTheme.textInverse
        )
    }
    
    private func toast(background: Color, foreground: Color) -> some View {
        HStack(spacing: 12) {
            if let icon = state.icon {
                NoctIconView(icon, size: .lg, color: foreground)
            }
            VStack(alignment: .leading, spacing: 6) {
                if let title = state.title {
                    Text(title)
                        .noctTextStyle(.body(), weight: .bold)
                        .foregroundStyle(foreground)
                        .lineLimit(1)
                }
                Text(state.message)
                    .noctTextStyle(.body())
                    .foregroundStyle(foreground)
                    .lineLimit(2)
            }
            Spacer()
            if let action = state.action {
                actionView(action, foreground: foreground)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .frame(maxWidth: .infinity)
        .background(background)
        .clipShape(
            RoundedRectangle(cornerRadius: noctTheme.radius.md)
        )
        .noctShadow(.elevated)
        .onTapGesture {
            guard state.dismissible else { return }
            presenter?.dismiss()
        }
    }
    
    @ViewBuilder
    private func actionView(_ action: NoctToastAction, foreground: Color) -> some View {
        switch action.view {
        case let .text(text):
            Button(text) {
                action.handler()
            }
            .buttonStyle(.plain)
            .noctTextStyle(.body(.sm), weight: .semibold)
            .foregroundStyle(foreground)
            
        case let .icon(icon):
            Button {
                action.handler()
            } label: {
                NoctIconView(icon, size: .md, color: foreground)
            }
            .buttonStyle(.plain)
        }
    }
}
