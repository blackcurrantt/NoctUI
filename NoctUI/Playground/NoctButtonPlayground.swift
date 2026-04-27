//
//  NoctButtonPlayground.swift
//  NoctUI
//
//  Created by blackcurrantt
//

import SwiftUI

struct NoctButtonPlayground: View {
    @Environment(\.noctTheme) private var noctTheme
    
    private enum Variant: String, CaseIterable, Equatable {
        case primary, secondary, success, warning, error, info, custom
    }
    @State private var selectedVariant: Variant = .primary
    
    private enum Dimension: CaseIterable, Equatable {
        case sm, md, lg

        var noct: NoctButtonDimension {
            switch self {
            case .sm: .sm
            case .md: .md
            case .lg: .lg
            }
        }
    }
    @State private var selectedDimension: Dimension = .md
    
    private enum Shape: CaseIterable, Equatable {
        case standard, pill
        
        var noct: NoctShape {
            switch self {
            case .standard: .standard
            case .pill: .pill
            }
        }
        
        init(_ noct: NoctShape) {
            switch noct {
            case .standard:
                self = .standard
            case .pill:
                self = .pill
            }
        }
    }
    @State private var selectedShape: Shape = .standard
    
    private var currentStyle: NoctButtonStyle {
        switch selectedVariant {
        case .primary:
            return .primary(selectedDimension.noct, shape: selectedShape.noct)
        case .secondary:
            return .secondary(selectedDimension.noct, shape: selectedShape.noct)
        case .success:
            return .success(selectedDimension.noct, shape: selectedShape.noct)
        case .warning:
            return .warning(selectedDimension.noct, shape: selectedShape.noct)
        case .error:
            return .error(selectedDimension.noct, shape: selectedShape.noct)
        case .info:
            return .info(selectedDimension.noct, shape: selectedShape.noct)
        case .custom:
            return .custom(
                selectedDimension.noct,
                shape: selectedShape.noct,
                background: Color(.label),
                foreground: Color(.systemBackground)
            )
        }
    }
    
    private let springAnimation = Animation.spring(response: 0.35, dampingFraction: 0.8)

    var body: some View {
        PlaygroundView(height: NoctButtonDimension.lg.height, useCard: true) {
            Button("Noct") { }
                .buttonStyle(currentStyle)
                .animation(springAnimation, value: selectedVariant)
                .animation(springAnimation, value: selectedDimension)
                .animation(springAnimation, value: selectedShape)
        } config: {
            PlaygroundSection("Variant") {
                PlaygroundVariantPicker($selectedVariant)
            }

            PlaygroundSection("Dimension") {
                PlaygroundPicker($selectedDimension)
            }
            
            PlaygroundSection("Shape") {
                PlaygroundPicker($selectedShape)
            }
        }
        .onAppear {
            selectedShape = Shape(noctTheme.buttonShape)
        }
        .onChange(of: noctTheme.buttonShape) { _, newValue in
            selectedShape = Shape(newValue)
        }
    }
}

#Preview {
    NavigationStack {
        NoctButtonPlayground()
    }
}
