//
//  LoginView.swift
//  remember-me
//
//  Created by Xiaoya Zou on 2025-03-29.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct LoginView: View {
    @Binding var isLoggedIn: Bool
    
    @State private var email = ""
    @State private var password = ""
    
    // Which main view to show
    @State private var showMainTabView = false
    @State private var showCaregiverMainTabView = false
    
    // UI feedback
    @State private var loginError: String?
    @State private var isLoading = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                
                Text("Welcome to Remember Me!")
                    .font(.largeTitle)
                    .bold()
                
                // No more segmented picker
                // The user's accountType is determined from Firestore after login

                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.emailAddress)
                    .autocorrectionDisabled(true)
                    .textInputAutocapitalization(.never)

                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                if let loginError = loginError {
                    Text(loginError)
                        .foregroundColor(.red)
                        .font(.footnote)
                }

                Button(action: {
                    loginUser()
                }) {
                    if isLoading {
                        ProgressView()
                            .tint(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                    } else {
                        Text("Log In")
                            .frame(maxWidth: .infinity)
                            .padding()
                    }
                }
                .background(Color.accentColor)
                .foregroundColor(.white)
                .cornerRadius(8)
                .disabled(isLoading)

                // Sign Up link
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
        // If showMainTabView is true, present that fullscreen
        .fullScreenCover(isPresented: $showMainTabView) {
            MainTabView()
                .navigationBarBackButtonHidden(true)
        }
        // If showCaregiverMainTabView is true, present that fullscreen
        .fullScreenCover(isPresented: $showCaregiverMainTabView) {
            CareGiverMainTabView()
                .navigationBarBackButtonHidden(true)
        }
    }

    // MARK: - Firebase Login Logic
    private func loginUser() {
        // Reset old error
        loginError = nil
        isLoading = true

        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            DispatchQueue.main.async {
                self.isLoading = false
            }

            if let error = error {
                DispatchQueue.main.async {
                    self.loginError = error.localizedDescription
                }
                return
            }

            // If login successful, fetch user doc to see if they're a caregiver or not
            guard let uid = Auth.auth().currentUser?.uid else { return }
            
            let db = Firestore.firestore()
            db.collection("users").document(uid).getDocument { docSnap, error in
                if let error = error {
                    DispatchQueue.main.async {
                        self.loginError = "Error fetching user type: \(error.localizedDescription)"
                    }
                    return
                }
                
                guard let data = docSnap?.data() else {
                    DispatchQueue.main.async {
                        self.loginError = "User record not found in Firestore."
                    }
                    return
                }
                
                // Read the 'accountType' field
                let accountType = data["accountType"] as? String ?? "Patient"
                
                DispatchQueue.main.async {
                    self.isLoggedIn = true
                    if accountType == "Caregiver" {
                        self.showCaregiverMainTabView = true
                    } else {
                        self.showMainTabView = true
                    }
                }
            }
        }
    }
}

#Preview {
    LoginView(isLoggedIn: .constant(false))
}
