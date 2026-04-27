//
//  NoctButtonStyle+Variant.swift
//  NoctUI
//
//  Created by blackcurrantt
//

import SwiftUI

public extension NoctButtonStyle {
    static func primary(
        _ dimension: NoctButtonDimension = .md,
        shape: NoctShape? = nil
    ) -> NoctButtonStyle {
        NoctButtonStyle(
            dimension: dimension,
            shape: shape,
            backgroundProvider: { $0.primary },
            foregroundProvider: { $0.textInverse }
        )
    }

    static func secondary(
        _ dimension: NoctButtonDimension = .md,
        shape: NoctShape? = nil
    ) -> NoctButtonStyle {
        NoctButtonStyle(
            dimension: dimension,
            shape: shape,
            backgroundProvider: { $0.secondary },
            foregroundProvider: { $0.textDefault }
        )
    }
    
    static func success(
        _ dimension: NoctButtonDimension = .md,
        shape: NoctShape? = nil
    ) -> NoctButtonStyle {
        NoctButtonStyle(
            dimension: dimension,
            shape: shape,
            backgroundProvider: { $0.success },
            foregroundProvider: { $0.textInverse }
        )
    }
    
    static func warning(
        _ dimension: NoctButtonDimension = .md,
        shape: NoctShape? = nil
    ) -> NoctButtonStyle {
        NoctButtonStyle(
            dimension: dimension,
            shape: shape,
            backgroundProvider: { $0.warning },
            foregroundProvider: { $0.textInverse }
        )
    }
    
    static func error(
        _ dimension: NoctButtonDimension = .md,
        shape: NoctShape? = nil
    ) -> NoctButtonStyle {
        NoctButtonStyle(
            dimension: dimension,
            shape: shape,
            backgroundProvider: { $0.error },
            foregroundProvider: { $0.textInverse }
        )
    }
    
    static func info(
        _ dimension: NoctButtonDimension = .md,
        shape: NoctShape? = nil
    ) -> NoctButtonStyle {
        NoctButtonStyle(
            dimension: dimension,
            shape: shape,
            backgroundProvider: { $0.info },
            foregroundProvider: { $0.textInverse }
        )
    }
    
    static func custom(
        _ dimension: NoctButtonDimension = .md,
        shape: NoctShape? = nil,
        background: Color,
        foreground: Color
    ) -> NoctButtonStyle {
        NoctButtonStyle(
            dimension: dimension,
            shape: shape,
            background: background,
            foreground: foreground,
            backgroundProvider: { $0.primary },
            foregroundProvider: { $0.textInverse }
        )
    }
}
