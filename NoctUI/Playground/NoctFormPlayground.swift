//
//  NoctFormPlayground.swift
//  NoctUI
//
//  Created by blackcurrantt
//

import SwiftUI

struct NoctFormPlayground: View {
    private struct ProfileForm {
        var name: String = ""
        var age: String = ""
        var bio: String = ""
    }
    
    @State private var form = ProfileForm()

    var body: some View {
        NoctForm($form) { onSubmit in
            NoctFormInput(\ProfileForm.name) {
                NoctTextField(text: $0, label: "Name")
            }

            NoctFormInput(\ProfileForm.age) {
                NoctTextField(text: $0, label: "Age")
            }
            
            NoctFormInput(\ProfileForm.bio) {
                NoctTextView(text: $0, label: "Bio")
            }
            
            Button("Submit") {
                onSubmit()
            }
            .buttonStyle(NoctButtonStyle.primary())

        } onSubmit: { result in
            let name: String? = result[\.name]
            let age: String? = result[\.age]
            let bio: String? = result[\.bio]
            print("Name: ", name ?? "")
            print("Age: ", age ?? "")
            print("Bio: ", bio ?? "")
        }
        .padding()
    }
}

