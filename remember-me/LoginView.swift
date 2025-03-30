//
//  LoginView.swift
//  remember-me
//
//  Created by Xiaoya Zou on 2025-03-29.
//

import SwiftUI

struct LoginView: View {
    @Binding var isLoggedIn: Bool
    @State private var email = ""
    @State private var password = ""
    @State private var accountType = "Patient"
    @State private var showMainTabView = false

    let accountOptions = ["Patient", "Caregiver", "Healthcare Pro"]

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                
                Picker("Account Type", selection: $accountType) {
                    ForEach(accountOptions, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())

                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                Button(action: {
                    // Handle auth logic here
                    isLoggedIn = true
                    showMainTabView = true
                }) {
                    Text("Log In")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.accentColor)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }

                NavigationLink(destination: SignUpView()) {
                    Text("Don't have an account? ")
                        .font(.footnote)
                        .foregroundColor(.gray)
                    + Text("Sign up")
                        .font(.footnote)
                        .foregroundColor(.blue)
                        .underline()
                }
            }
            .padding()
        }
        .fullScreenCover(isPresented: $showMainTabView) {
            MainTabView()
                .navigationBarBackButtonHidden(true)
        }
    }
}


#Preview {
    LoginView(isLoggedIn: .constant(false))
}
