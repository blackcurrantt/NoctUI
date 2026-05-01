//
//  NoctToastContainer.swift
//  NoctUI
//
//  Created by blackcurrantt
//

import SwiftUI

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
                    .transition(transition(for: toast.position))
                    .zIndex(999)
                    .onDisappear {
                        NoctToastPresenter.shared.notifyDismissAnimationCompleted()
                    }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .animation(.spring(response: 0.35, dampingFraction: 0.8), value: presenter.currentState)
    }
    
    private func transition(for position: NoctToastPosition) -> AnyTransition {
        let insertion: AnyTransition
        let removal: AnyTransition = .opacity
        
        switch position {
        case .top:
            insertion = .move(edge: .top)
                .combined(with: .opacity)
                .combined(with: .scale(scale: 0.96))
            
        case .bottom:
            insertion = .move(edge: .bottom)
                .combined(with: .opacity)
                .combined(with: .scale(scale: 0.96))
        }
        
        return .asymmetric(
            insertion: insertion,
            removal: removal
        )
    }
}
