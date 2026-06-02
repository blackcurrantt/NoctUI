//
//  EdgeInsets+Ext.swift
//  NoctUI
//
//  Created by blackcurrantt
//

import SwiftUI

extension EdgeInsets {
    public static func all(_ value: CGFloat) -> EdgeInsets {
        .init(top: value, leading: value, bottom: value, trailing: value)
    }

    public func horizontal(_ value: CGFloat) -> EdgeInsets {
        var copy = self
        copy.leading = value
        copy.trailing = value
        return copy
    }

    public func vertical(_ value: CGFloat) -> EdgeInsets {
        var copy = self
        copy.top = value
        copy.bottom = value
        return copy
    }
}
