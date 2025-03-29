//
//  LoginView.swift
//  remember-me
//
//  Created by Xiaoya Zou on 2025-03-29.
//

import SwiftUI
// test

struct LoginView: View {
    @Binding var isLoggedIn: Bool
    @State private var email = ""
    @State private var password = ""
    @State private var accountType = "Patient"
    @State private var navigateToHome = false
    
    let accountOptions = ["Patient", "Caregiver", "Healthcare Pro"]

    var body: some View {
        NavigationStack{
            VStack(spacing: 20) {
                // test by xiaoya
                
//                Text("Please select your role:")
//                    .font(.headline)
//                    .foregroundColor(.gray)
                
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
                    // Handle firebase auth later
                    isLoggedIn = true
                    navigateToHome = true
                }) {
                    Text("Log In")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.accentColor)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }

                NavigationLink(destination: HomeView(), isActive: $navigateToHome) {
                    EmptyView()
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
    }
}


#Preview {
    LoginView(isLoggedIn: .constant(false))
}
