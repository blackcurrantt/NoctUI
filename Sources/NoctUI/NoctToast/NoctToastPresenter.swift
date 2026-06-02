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
    var currentState: NoctToastState?
    
    @ObservationIgnored
    private var task: Task<Void, Never>?

    @ObservationIgnored
    private var continuation: CheckedContinuation<Void, Never>?

    @ObservationIgnored
    private var generation = 0

    func show(_ state: NoctToastState) {
        task?.cancel()
        finishCurrentCycle()
        generation &+= 1
        let generation = generation

        task = Task {
            if currentState != nil {
                await dismissAndWait()
            }

            guard isCurrentGeneration(generation) else { return }
            
            currentState = state
            
            do {
                try await Task.sleep(
                    nanoseconds: NoctToastDuration.nanoseconds(
                        for: state.duration
                    )
                )
            } catch {
                return
            }

            if isCurrentGeneration(generation) {
                await dismissAndWait()

                if isCurrentGeneration(generation) {
                    task = nil
                }
            }
        }
    }

    func dismiss() {
        task?.cancel()
        task = nil
        generation &+= 1
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
        continuation.resume()
    }

    private func isCurrentGeneration(_ generation: Int) -> Bool {
        self.generation == generation && !Task.isCancelled
    }
}

private struct NoctToastPresenterKey: EnvironmentKey {
    static let defaultValue: NoctToastPresenter? = nil
}

extension EnvironmentValues {
    var noctToastPresenter: NoctToastPresenter? {
        get { self[NoctToastPresenterKey.self] }
        set { self[NoctToastPresenterKey.self] = newValue }
    }
}
