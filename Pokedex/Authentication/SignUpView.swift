//
//  SignUpView.swift
//  NewWaveStore
//
//  Created by Amber Wong (student LM) on 2/2/23.
//

import SwiftUI
import FirebaseAuth
import Firebase
import FirebaseCore

struct SignUpView: View {
    
    @State var username : String = ""
    @State var password: String = ""
    @State var cPassword: String = ""
    @State var signUpErrorMessage : String = ""
    @State var signUpProcessing : Bool = false
    @EnvironmentObject var viewRouter : ViewRouter
    
    var body: some View {
        ZStack {
            
            Rectangle()
                .foregroundColor(Color.red)
                .ignoresSafeArea()
            
            Rectangle()
                .foregroundColor(Color.white.opacity(0.3))
                .ignoresSafeArea()
            
            VStack(spacing: 10) {
                // Email Prompt
                TextField("emailish", text: $username, prompt: Text("Email"))
                    .padding()
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .background(Color.white.opacity(0.3))
                    .cornerRadius(20)
                // Password Prompt
                SecureField("password", text: $password, prompt: Text("Password"))
                    .padding()
                    .background(Color.white.opacity(0.3))
                    .cornerRadius(20)
                // Confirm Pasword Prompt
                SecureField("confirm password", text: $cPassword, prompt: Text("Confirm Password"))
                    .padding()
                    .background(Color.white.opacity(0.3))
                    .cornerRadius(20)
                
                HStack {
                    // Go to sign in page
                    Button {
                        viewRouter.viewState = .auth
                    } label: {
                        Text("Go Back")
                            .padding()
                            .background(Color.white.opacity(0.3))
                            .cornerRadius(20)
                    }
                    // Sign up Button
                    Button {
                        signUpUser(userEmail: username, userPassword: password)
                    } label: {
                        Text("Sign Up")
                            .padding()
                            .background(Color.white.opacity(0.3))
                            .cornerRadius(20)
                    }
                    .disabled(!signUpProcessing && !username.isEmpty && !username.isEmpty &&  !password.isEmpty && !cPassword.isEmpty && password == cPassword ? false : true)
                }
                
                if !signUpErrorMessage.isEmpty {
                    Text("Failed creating account: \(signUpErrorMessage)")
                        .foregroundColor(.red)
                }
                if signUpProcessing {
                    ProgressView()
                }
            }
            .padding()
        }
    }
    
    func signUpUser(userEmail: String, userPassword: String) {
        
        signUpProcessing = true
        Auth.auth().createUser(withEmail: userEmail, password: userPassword) { authResult, error in
            guard error == nil else {
                signUpErrorMessage = error?.localizedDescription ?? "Uh oh"
                signUpProcessing = false
                return
            }
            
            switch authResult {
            case .none:
                print("Could not create account")
                signUpProcessing = false
            case .some(_):
                print("Welcome!")
                signUpProcessing = false
                viewRouter.viewState = .auth
            }
        }
    }
    
}
