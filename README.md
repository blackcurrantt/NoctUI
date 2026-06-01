# NoctUI

NoctUI is an SPM-first SwiftUI component library. It aims to bring the
convenience of Bootstrap-style reusable UI to iOS: install one package, use
consistent components, and customize the visual language through a theme.

The repository also includes a small iOS playground app for exploring the
components during development.

## Requirements

- iOS 17+
- Swift 5.9+
- Xcode 15+

## Installation

In Xcode, open your app project and choose **File > Add Package
Dependencies...**. Enter this repository URL and add the `NoctUI` library to
your app target.

Or add NoctUI to your own `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/<your-account>/NoctUI.git", from: "0.1.0")
]
```

Then add the product to your target:

```swift
.target(
    name: "YourApp",
    dependencies: [
        .product(name: "NoctUI", package: "NoctUI")
    ]
)
```

Import the package wherever you build UI:

```swift
import NoctUI
import SwiftUI
```

## Quick Start

NoctUI ships with a default lunar theme, typography scale, and SF Symbol icon
provider. Wrap your root view in `NoctToastContainer` if you want to present
toasts from anywhere in your app.

```swift
import NoctUI
import SwiftUI

@main
struct ExampleApp: App {
    var body: some Scene {
        WindowGroup {
            NoctToastContainer {
                ContentView()
            }
            .noctTheme(NoctLunarTheme())
            .noctTypography(NoctLunarTypography())
            .noctIconProvider(.system)
        }
    }
}
```

## Forms

`NoctForm` and `NoctFormInput` bind controls to writable key paths on a form
model.

```swift
struct ProfileForm {
    var name = ""
    var email = ""
}

@State private var profile = ProfileForm()

NoctForm($profile) { submit in
    NoctFormInput(\ProfileForm.name) { value in
        NoctTextField(text: value, label: "Name")
    }

    NoctFormInput(\ProfileForm.email) { value in
        NoctTextField(text: value, label: "Email")
    }

    Button("Save", action: submit)
        .buttonStyle(NoctButtonStyle.primary())
} onSubmit: { result in
    print(result[\ProfileForm.email])
}
```

## Components

### Buttons

Use a native SwiftUI `Button` with a NoctUI style. Variants are similar to
Bootstrap's contextual button classes.

```swift
VStack(spacing: 12) {
    Button("Continue") {}
        .buttonStyle(NoctButtonStyle.primary())

    Button("Delete") {}
        .buttonStyle(NoctButtonStyle.error(.sm, shape: .pill))

    Button("Disabled") {}
        .buttonStyle(NoctButtonStyle.secondary())
        .disabled(true)
}
```

Available variants: `primary`, `secondary`, `success`, `warning`, `error`, and
`info`. Available dimensions: `sm`, `md`, and `lg`.

### Cards

```swift
NoctCard(border: 1, shadow: .card) {
    VStack(alignment: .leading, spacing: 8) {
        Text("Account")
            .noctTextStyle(.title(.sm))
        Text("Manage your profile and security settings.")
            .noctTextStyle(.body(.sm))
    }
}
```

### Chips

```swift
NoctChip(
    title: "SwiftUI",
    style: .outlined,
    isSelected: true,
    prefixIcon: NoctIcon(.success)
) {
    print("Selected")
}
```

### Text Fields

```swift
@State private var email = ""
@State private var password = ""

NoctTextField(
    text: $email,
    label: "Email",
    placeholder: "you@example.com",
    hint: "We will only use this for sign in.",
    accessory: .clear,
    keyboardType: .emailAddress
)

NoctTextField(
    text: $password,
    label: "Password",
    accessory: .secure()
)
```

For multiline input, use `NoctTextView`.

```swift
@State private var bio = ""

NoctTextView(
    text: $bio,
    label: "Bio",
    placeholder: "Tell us a little about yourself",
    height: 140
)
```

### Toasts

After adding `NoctToastContainer` at the app root, show semantic toast variants
from any UI action:

```swift
NoctToast.show(
    .success(
        "Your profile was saved.",
        title: "Done",
        showsIcon: true,
        action: .close()
    )
)
```

Available variants: `success`, `warning`, `error`, and `info`.

### Icons

NoctUI uses semantic icon tokens. Built-in tokens resolve to SF Symbols by
default.

```swift
NoctIconView(.warning, size: .lg)
NoctIconView(.system("sparkles"), size: .custom(28))
NoctIconView(.asset("brand-logo"))
```

Override tokens with your own provider:

```swift
let icons = NoctIconProvider { token in
    switch token {
    case .success:
        return .asset("check-badge")
    default:
        return nil
    }
}

ContentView()
    .noctIconProvider(icons)
```

Unmatched tokens fall back to the built-in system provider.

## Custom Theme

Conform to `NoctTheme` and override only the tokens you need. Every token has a
default implementation, so a theme can stay small.

```swift
struct BrandTheme: NoctTheme {
    var primary: Color { Color(hex: 0x7C3AED) }
    var surface: Color { Color(hex: 0x111827) }
    var card: Color { Color(hex: 0x1F2937) }
    var radius: NoctRadius { NoctRadius(sm: 6, md: 10, lg: 14) }
    var buttonShape: NoctShape { .pill }
}

ContentView()
    .noctTheme(BrandTheme())
```

You can also supply a custom typography implementation with
`.noctTypography(...)`.

## Included Building Blocks

| Area | API |
| --- | --- |
| Theme | `NoctTheme`, `NoctLunarTheme` |
| Typography | `NoctTypography`, `NoctLunarTypography`, `.noctTextStyle(...)` |
| Buttons | `NoctButtonStyle` |
| Content | `NoctCard`, `NoctChip` |
| Input | `NoctTextField`, `NoctTextView`, `NoctForm` |
| Feedback | `NoctToast`, `NoctToastContainer` |
| Icons | `NoctIcon`, `NoctIconToken`, `NoctIconProvider`, `NoctIconView` |

## Development

Open `NoctUI.xcodeproj` to run the component playground app. To validate the
Swift package manifest from the command line:

```sh
swift package dump-package
```
