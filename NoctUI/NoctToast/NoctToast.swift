//
//  NoctToast.swift
//  NoctUI
//
//  Created by blackcurrantt
//

import SwiftUI

public enum NoctToast {
    public static func show(_ state: NoctToastState) {
        NoctToastPresenter.shared.show(state)
    }
}

// MARK: - NoctToastPresenter

@MainActor
@Observable
final class NoctToastPresenter {
    static let shared = NoctToastPresenter()
    
    var currentState: NoctToastState?

    private var task: Task<Void, Never>?

    func show(_ state: NoctToastState) {
        task?.cancel()
        currentState = state
        task = Task {
            try? await Task.sleep(nanoseconds: UInt64(state.duration * 1_000_000_000))
            if !Task.isCancelled, currentState?.id == state.id {
                currentState = nil
            }
        }
    }
}
