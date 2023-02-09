//
//  SignInView.swift
//  NewWaveStore
//
//  Created by Amber Wong (student LM) on 2/2/23.
//

import SwiftUI
import FirebaseAuth
import Firebase

struct SignInView: View {
    
    @State var signInProcessing = false
    @State var signInErrorMessage = ""
    @EnvironmentObject var viewRouter : ViewRouter
    @EnvironmentObject var user : User
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color.red)
                .ignoresSafeArea()
            
            Rectangle()
                .foregroundColor(Color.white.opacity(0.3))
                .ignoresSafeArea()
            
            VStack {
                TextField("emailish", text: $user.username, prompt: Text("email"))
                    .padding()
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .background(Color.white.opacity(0.3))
                    .cornerRadius(20)
                SecureField("password", text: $user.password, prompt: Text("password"))
                    .padding()
                    .background(Color.white.opacity(0.3))
                    .cornerRadius(20)
                HStack {
                    Button {
                        viewRouter.viewState = .auth
                    } label: {
                        Text("Go Back")
                            .padding()
                            .background(Color.white.opacity(0.3))
                            .cornerRadius(20)
                    }
                    
                    Button(action: {
                        signInUser(userEmail: user.username, userPassword: user.password)
                    }) {
                        Text("Log In")
                            .padding()
                            .background(Color.white.opacity(0.3))
                            .cornerRadius(20)
                    }
                    .disabled(!signInProcessing && !user.username.isEmpty && !user.password.isEmpty ? false : true)
                }
                if signInProcessing {
                    ProgressView()
                }
                if !signInErrorMessage.isEmpty {
                    Text("Failed creating account: \(signInErrorMessage)")
                        .foregroundColor(.white)
                }
            }
            .padding()
        }
    }
    
    func signInUser(userEmail: String, userPassword: String) {
        
        signInProcessing = true
        
        Auth.auth().signIn(withEmail: userEmail, password: userPassword) { authResult, error in
            guard error == nil else {
                signInProcessing = false
                signInErrorMessage = error?.localizedDescription ?? "Uh oh"
                return
            }
            
            switch authResult {
            case .none:
                print("Could not sign in user.")
                signInProcessing = false
            case .some(_):
                print("User signed in")
                signInProcessing = false
                viewRouter.viewState = .home
            }
        }
    }
}
