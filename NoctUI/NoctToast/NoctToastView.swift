//
//  NoctToastView.swift
//  NoctUI
//
//  Created by blackcurrantt
//

import SwiftUI

public struct NoctToastView: View {
    @Environment(\.noctTheme) private var noctTheme
    
    private let state: NoctToastState
    
    public init(state: NoctToastState) {
        self.state = state
    }
    
    public var body: some View {
        VStack {
            if state.position == .top {
                toast
                Spacer()
            } else {
                Spacer()
                toast
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
    }
    
    private var toast: some View {
        HStack {
            Text(state.message)
                .noctTextStyle(.body())
                .foregroundStyle(foreground)
            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .frame(maxWidth: .infinity)
        .background(background)
        .clipShape(
            RoundedRectangle(cornerRadius: noctTheme.radius.md)
        )
        .noctShadow(.elevated)
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
}

// MARK: - NoctToastContainer

public struct NoctToastContainer<Content: View>: View {
    private let presenter = NoctToastPresenter.shared
    private let content: Content
    
    public init(
        @ViewBuilder content: () -> Content
    ) {
        self.content = content()
    }

    public var body: some View {
        ZStack {
            content
            if let toast = presenter.currentState {
                NoctToastView(state: toast)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
}
