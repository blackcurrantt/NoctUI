//
//  NoctForm.swift
//  NoctUI
//
//  Created by blackcurrantt
//

import SwiftUI

// MARK: - NoctFormContext

@Observable
public final class NoctFormContext {
    var values: [AnyHashable: Any] = [:]
    var submit: (() -> Void)?

    func register<Value>(key: some Hashable, value: Value) {
        values[AnyHashable(key)] = value
    }
    
    func update<Value>(key: some Hashable, value: Value) {
        values[AnyHashable(key)] = value
    }
}

// MARK: - NoctFormResult

public struct NoctFormResult {
    fileprivate let values: [AnyHashable: Any]
    
    public subscript<T>(_ key: some Hashable) -> T? {
        values[AnyHashable(key)] as? T
    }

    public var dictionary: [AnyHashable: Any] {
        values
    }
}

// MARK: - NoctForm

public struct NoctForm<Content: View>: View {
    @State private var context = NoctFormContext()

    private let spacing: CGFloat
    private let content: Content
    private let onSubmit: (NoctFormResult) -> Void

    public init(
        spacing: CGFloat = 16,
        @ViewBuilder content: () -> Content,
        onSubmit: @escaping (NoctFormResult) -> Void
    ) {
        self.spacing = spacing
        self.content = content()
        self.onSubmit = onSubmit
    }

    public var body: some View {
        VStack(spacing: spacing) {
            content
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity,
            alignment: .top
        )
        .environment(context)
        .task {
            context.submit = {
                let result = NoctFormResult(values: context.values)
                onSubmit(result)
            }
        }
    }
}

// MARK: - NoctFormInput

public struct NoctFormInput<Key: Hashable, Value, Content: View>: View {
    @Environment(NoctFormContext.self) private var context
    @Binding private var value: Value
    
    private let key: Key
    private let content: (Binding<Value>) -> Content

    public init(
        _ key: Key,
        _ value: Binding<Value>,
        @ViewBuilder content: @escaping (Binding<Value>) -> Content
    ) {
        self.key = key
        self._value = value
        self.content = content
    }

    public var body: some View {
        let trackedBinding = Binding(
            get: { value },
            set: { newValue in
                value = newValue
                context.update(key: key, value: newValue)
            }
        )
        content(trackedBinding)
            .onAppear {
                context.register(key: key, value: value)
            }
    }
}

// MARK: - NoctFormSubmitModifier

public struct NoctFormSubmitModifier: ViewModifier {
    @Environment(NoctFormContext.self) private var context

    public func body(content: Content) -> some View {
        content
            .simultaneousGesture(
                TapGesture().onEnded {
                    context.submit?()
                }
            )
    }
}

public extension View {
    func noctFormSubmit() -> some View {
        modifier(NoctFormSubmitModifier())
    }
}
