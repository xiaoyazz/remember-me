//
//  SignUpView.swift
//  remember-me
//
//  Created by Xiaoya Zou on 2025-03-29.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore


struct SignUpView: View {
    @State private var name = ""
    @State private var age = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var accountType = "Patient"
    
    @State private var showSuccessAlert = false

    
    @State private var errorMessage = ""
    @Environment(\.dismiss) var dismiss
    
    let accountOptions = ["Patient", "Caregiver", "Healthcare Pro"]
    
    var body: some View {
        
        // test by xiaoya
        
        VStack(spacing: 20) {
            
            Spacer()
            
            Text("Create your account")
                .font(.title2)
                .bold()
            
            Picker("Account Type", selection: $accountType) {
                ForEach(accountOptions, id: \.self) {
                    Text($0)
                }
            }
            .pickerStyle(SegmentedPickerStyle())

            TextField("Name", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            TextField("Age", text: $age)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.numberPad)

            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.emailAddress)

            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            SecureField("Confirm Password", text: $confirmPassword)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            if !errorMessage.isEmpty {
                Text(errorMessage)
                    .foregroundColor(.red)
            }

            Button("Sign Up") {
                handleSignUp()
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.accentColor)
            .foregroundColor(.white)
            .cornerRadius(8)

            Spacer()
        }
        .padding()
        .navigationTitle("Sign Up")
        .navigationBarTitleDisplayMode(.inline)
        
        .alert("Success", isPresented: $showSuccessAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("Your account was created successfully!")
        }
    }
    
    func handleSignUp() {
        errorMessage = ""

        guard !name.isEmpty, !age.isEmpty, !email.isEmpty, !password.isEmpty else {
            errorMessage = "Please fill out all fields."
            return
        }

        guard password == confirmPassword else {
            errorMessage = "Passwords do not match."
            return
        }

        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                self.errorMessage = error.localizedDescription
                return
            }

            // Save extra user info to Firestore
            let db = Firestore.firestore()
            db.collection("users").document(result!.user.uid).setData([
                "name": name,
                "email": email,
                "age": age,
                "accountType": accountType
            ]) { error in
                if let error = error {
                    self.errorMessage = "Failed to save user data: \(error.localizedDescription)"
                } else {
                    self.showSuccessAlert = true
                }
            }
        }

    }
}


#Preview {
    SignUpView()
}
