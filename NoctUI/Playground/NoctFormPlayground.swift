//
//  NoctFormPlayground.swift
//  NoctUI
//
//  Created by blackcurrantt
//

import SwiftUI

struct NoctFormPlayground: View {
    private enum FormInput {
        case name
        case bio
    }
    
    @State private var name = ""
    @State private var bio = ""

    var body: some View {
        NoctForm {
            NoctFormInput(FormInput.name, $name) {
                NoctTextField(text: $0, label: "Name")
            }

            NoctFormInput(FormInput.bio, $bio) {
                NoctTextView(text: $0, label: "Bio")
            }
            
            Button("Submit") { }
                .buttonStyle(NoctButtonStyle.primary())
                .noctFormSubmit()

        } onSubmit: { result in
            let name: String? = result[FormInput.name]
            let bio: String? = result[FormInput.bio]
            print(name ?? "")
            print(bio ?? "")
        }
        .padding()
    }
}

