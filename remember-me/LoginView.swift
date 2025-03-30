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

    @State private var showMainMemoryView = false
    @State private var showCaregiverMainTabView = false

    @State private var loginError: String?
    @State private var isLoading = false

    @StateObject private var statsManager = GameStatsManager()
    @StateObject private var metricsLogger = MetricsLogger()

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("Welcome to Remember Me!")
                    .font(.largeTitle)
                    .bold()

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

                Button(action: loginUser) {
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
        .fullScreenCover(isPresented: $showMainMemoryView) {
            MainMemeoryView()
                .environmentObject(statsManager)
                .environmentObject(metricsLogger)
                .navigationBarBackButtonHidden(true)
        }
        .fullScreenCover(isPresented: $showCaregiverMainTabView) {
            CareGiverMainTabView()
                .navigationBarBackButtonHidden(true)
        }

    }

    private func loginUser() {
        loginError = nil
        isLoading = true

        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            DispatchQueue.main.async {
                isLoading = false
            }

            if let error = error {
                DispatchQueue.main.async {
                    loginError = error.localizedDescription
                }
                return
            }

            guard let uid = Auth.auth().currentUser?.uid else { return }

            let db = Firestore.firestore()
            db.collection("users").document(uid).getDocument { docSnap, error in
                if let error = error {
                    DispatchQueue.main.async {
                        loginError = "Error fetching user type: \(error.localizedDescription)"
                    }
                    return
                }

                guard let data = docSnap?.data() else {
                    DispatchQueue.main.async {
                        loginError = "User record not found."
                    }
                    return
                }


                let userAge = data["age"] as? Int ?? 0
                let accountType = data["accountType"] as? String ?? "Patient"

                DispatchQueue.main.async {
                    statsManager.stats.userAge = userAge
                    print("User Age from Firestore: \(userAge)")
                    isLoggedIn = true
                    if accountType == "Caregiver" {
                        showCaregiverMainTabView = true
                    } else {
                        showMainMemoryView = true
                    }
                }
            }
        }
    }
}


#Preview {
    LoginView(isLoggedIn: .constant(false))
}
