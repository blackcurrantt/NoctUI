//
//  NoctForm.swift
//  NoctUI
//
//  Created by blackcurrantt
//

import SwiftUI

// MARK: - NoctFormContext

public final class NoctFormContext<Form> {
    fileprivate let form: Binding<Form>

    init(form: Binding<Form>) {
        self.form = form
    }

    func binding<Value>(for keyPath: WritableKeyPath<Form, Value>) -> Binding<Value> {
        Binding(
            get: {
                return self.form.wrappedValue[keyPath: keyPath]
            },
            set: { newValue in
                self.form.wrappedValue[keyPath: keyPath] = newValue
            }
        )
    }
}

private struct NoctFormContextKey: EnvironmentKey {
    static let defaultValue: Any? = nil
}

private extension EnvironmentValues {
    var noctFormContext: Any? {
        get { self[NoctFormContextKey.self] }
        set { self[NoctFormContextKey.self] = newValue }
    }
}

// MARK: - NoctFormResult

public struct NoctFormResult<Form> {
    fileprivate let form: Form

    public subscript<Value>(_ keyPath: KeyPath<Form, Value>) -> Value {
        form[keyPath: keyPath]
    }
}

// MARK: - NoctForm

public struct NoctForm<Form, Content: View>: View {
    @Binding private var form: Form
    private let spacing: CGFloat
    private let content: (_ onSubmit: @escaping () -> Void) -> Content
    private let onSubmit: (NoctFormResult<Form>) -> Void

    public init(
        _ form: Binding<Form>,
        spacing: CGFloat = 16,
        @ViewBuilder content: @escaping (_ onSubmit: @escaping () -> Void) -> Content,
        onSubmit: @escaping (NoctFormResult<Form>) -> Void
    ) {
        self._form = form
        self.spacing = spacing
        self.content = content
        self.onSubmit = onSubmit
    }

    public var body: some View {
        VStack(spacing: spacing) {
            content {
                onSubmit(NoctFormResult(form: form))
            }
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity,
            alignment: .top
        )
        .environment(\.noctFormContext, NoctFormContext(form: $form))
    }
}

// MARK: - NoctFormInput

public struct NoctFormInput<Form, Value, Content: View>: View {
    @Environment(\.noctFormContext) private var context
    
    private let keyPath: WritableKeyPath<Form, Value>
    private let content: (Binding<Value>) -> Content

    public init(
        _ keyPath: WritableKeyPath<Form, Value>,
        @ViewBuilder content: @escaping (Binding<Value>) -> Content
    ) {
        self.keyPath = keyPath
        self.content = content
    }

    public var body: some View {
        if let context = context as? NoctFormContext<Form> {
            content(context.binding(for: keyPath))
                .id(keyPath)
        }
    }
}
