//
//  NoctToast.swift
//  NoctUI
//
//  Created by blackcurrantt
//

import SwiftUI

public enum NoctToast {
    @MainActor static weak var presenter: NoctToastPresenter?
    
    public static func show(_ state: NoctToastState) {
        Task { @MainActor in
            presenter?.show(state)
        }
    }
    
    public static func dismiss() {
        Task { @MainActor in
            presenter?.dismiss()
        }
    }
}
