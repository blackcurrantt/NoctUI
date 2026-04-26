//
//  PlaygroundVariantPicker.swift
//  NoctUI
//
//  Created by blackcurrantt
//

import SwiftUI

struct PlaygroundVariantPicker<Selection: CaseIterable & Hashable>: View {
    @Environment(\.colorScheme) private var scheme
    
    @Binding var selection: Selection
    
    private let options = Array(Selection.allCases)
    
    private var containerColor: Color {
        scheme == .dark
            ? Color(.systemGray6).opacity(0.9)
            : Color(.systemGray5).opacity(0.7)
    }

    private var selectedColor: Color {
        scheme == .dark
            ? Color(.systemGray2)
            : Color(.systemBackground)
    }

    private var textColor: Color {
        .primary
    }
    
    init(_ selection: Binding<Selection>) {
        self._selection = selection
    }
    
    var body: some View {
        FlowLayout(spacing: 8) {
            ForEach(options, id: \.self) { option in
                chip(option)
            }
        }
    }
    
    private func chip(_ option: Selection) -> some View {
        let isSelected = selection == option
        
        return Text(title(for: option))
            .font(.subheadline)
            .foregroundStyle(textColor)
            .fixedSize()
            .padding(.horizontal, 15)
            .padding(.vertical, 6.5)
            .background(
                Capsule()
                    .fill(isSelected ? selectedColor : containerColor)
            )
            .overlay(
                Capsule()
                    .stroke(containerColor, lineWidth: 1.5)
            )
            .contentShape(Rectangle())
            .onTapGesture {
                withAnimation(.easeInOut(duration: 0.15)) {
                    selection = option
                }
            }
    }
    
    private func title(for option: Selection) -> String {
        String(describing: option)
    }
}

private struct FlowLayout: Layout {
    var spacing: CGFloat = 8
    
    func sizeThatFits(
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout ()
    ) -> CGSize {
        let maxWidth = proposal.width ?? 0
        
        var x: CGFloat = 0
        var y: CGFloat = 0
        var rowHeight: CGFloat = 0
        
        for view in subviews {
            let size = view.sizeThatFits(.unspecified)
            
            if x + size.width > maxWidth {
                x = 0
                y += rowHeight + spacing
                rowHeight = 0
            }
            
            rowHeight = max(rowHeight, size.height)
            x += size.width + spacing
        }
        
        return CGSize(width: maxWidth, height: y + rowHeight)
    }
    
    func placeSubviews(
        in bounds: CGRect,
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout ()
    ) {
        var x = bounds.minX
        var y = bounds.minY
        var rowHeight: CGFloat = 0
        
        for view in subviews {
            let size = view.sizeThatFits(.unspecified)
            
            if x + size.width > bounds.maxX {
                x = bounds.minX
                y += rowHeight + spacing
                rowHeight = 0
            }
            
            view.place(
                at: CGPoint(x: x, y: y),
                proposal: ProposedViewSize(size)
            )
            
            rowHeight = max(rowHeight, size.height)
            x += size.width + spacing
        }
    }
}
