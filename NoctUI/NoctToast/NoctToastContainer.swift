//
//  NoctToastContainer.swift
//  NoctUI
//
//  Created by blackcurrantt
//

import SwiftUI

public struct NoctToastContainer<Content: View>: View {
    @State private var presenter = NoctToastPresenter()
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
                        presenter.notifyDismissAnimationCompleted()
                    }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .animation(.spring(response: 0.35, dampingFraction: 0.8), value: presenter.currentState)
        .environment(\.noctToastPresenter, presenter)
        .onAppear {
            NoctToast.presenter = presenter
        }
        .onDisappear {
            presenter.dismiss()
            
            if NoctToast.presenter === presenter {
                NoctToast.presenter = nil
            }
        }
    }
    
    private func transition(for position: NoctToastPosition) -> AnyTransition {
        switch position {
        case .top:
            return NoctToastTransitions.top
        case .bottom:
            return NoctToastTransitions.bottom
        }
    }
}

private enum NoctToastTransitions {
    static let top = toastTransition(edge: .top)
    static let bottom = toastTransition(edge: .bottom)

    private static func toastTransition(edge: Edge) -> AnyTransition {
        return .asymmetric(
            insertion: .move(edge: edge)
                .combined(with: .opacity)
                .combined(with: .scale(scale: 0.96)),
            removal: .opacity
        )
    }
}
