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
    
    public static func dismiss() {
        NoctToastPresenter.shared.dismiss()
    }
}
