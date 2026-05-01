//
//  NoctToastPresenter.swift
//  NoctUI
//
//  Created by blackcurrantt
//

import SwiftUI

@MainActor
@Observable
final class NoctToastPresenter {
    static let shared = NoctToastPresenter()
    
    var currentState: NoctToastState?
    
    private var task: Task<Void, Never>?
    private var continuation: CheckedContinuation<Void, Never>?

    func show(_ state: NoctToastState) {
        task?.cancel()
        
        finishCurrentCycle()

        task = Task {
            if currentState != nil {
                await dismissAndWait()
            }
            
            currentState = state
            
            do {
                try await Task.sleep(
                    nanoseconds: UInt64(state.duration * 1_000_000_000)
                )
            } catch {
                return
            }

            if !Task.isCancelled {
                await dismissAndWait()
            }
        }
    }

    func dismiss() {
        task?.cancel()
        currentState = nil
        finishCurrentCycle()
    }
    
    func notifyDismissAnimationCompleted() {
        guard let continuation else { return }
        self.continuation = nil
        continuation.resume()
    }

    private func dismissAndWait() async {
        guard currentState != nil else { return }
        currentState = nil
        await withCheckedContinuation { continuation in
            self.continuation = continuation
        }
    }
    
    private func finishCurrentCycle() {
        guard let continuation else { return }
        self.continuation = nil
        Task { @MainActor in
            continuation.resume()
        }
    }
}
