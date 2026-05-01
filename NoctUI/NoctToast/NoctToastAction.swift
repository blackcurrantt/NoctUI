//
//  NoctToastAction.swift
//  NoctUI
//
//  Created by blackcurrantt
//

import SwiftUI

public struct NoctToastAction {
    enum ViewType {
        case text(String)
        case icon(String)
    }
    
    let view: ViewType
    let handler: @MainActor () -> Void
    
    init(
        _ view: ViewType,
        _ handler: @escaping () -> Void
    ) {
        self.view = view
        self.handler = handler
    }
}

extension NoctToastAction {
    public static func text(
        _ text: String,
        _ handler: @escaping @MainActor () -> Void
    ) -> NoctToastAction {
        NoctToastAction(.text(text), handler)
    }
    
    public static func close() -> NoctToastAction {
        NoctToastAction(.icon("xmark")) {
            NoctToast.dismiss()
        }
    }
}
