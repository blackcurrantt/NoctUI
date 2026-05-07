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
    
    private var background: Color {
        if let background = state.background {
            return background
        } else if let provided = state.backgroundProvider?(noctTheme) {
            return provided
        } else {
            return noctTheme.toast
        }
    }
    
    private var foreground: Color {
        if let foreground = state.foreground {
            return foreground
        } else if let provided = state.foregroundProvider?(noctTheme) {
            return provided
        } else {
            return noctTheme.textInverse
        }
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
        toast
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: alignment)
            .padding(edgeInsets)
    }
    
    private var toast: some View {
        HStack(spacing: 12) {
            if let icon = state.icon {
                NoctIcon(icon, size: .lg, color: foreground)
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
                actionView(action)
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
    func actionView(_ action: NoctToastAction) -> some View {
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
                NoctIcon(icon, size: .md, color: foreground)
            }
            .buttonStyle(.plain)
        }
    }
}
