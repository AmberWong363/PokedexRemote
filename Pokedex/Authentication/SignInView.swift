//
//  SignInView.swift
//  NewWaveStore
//
//  Created by Amber Wong (student LM) on 2/2/23.
//

import SwiftUI
import FirebaseAuth
import FirebaseDatabase
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
                            .buttonStyle(.plain)
                    }
                    
                    Button(action: {
                        signInUser(userEmail: user.username, userPassword: user.password)
                    }) {
                        Text("Log In")
                            .padding()
                            .background(Color.white.opacity(0.3))
                            .cornerRadius(20)
                            .buttonStyle(.plain)
                    }
                    .disabled(!signInProcessing && !user.username.isEmpty && !user.password.isEmpty ? false : true)
                }
                Button {
                    viewRouter.viewState = .passReset
                } label: {
                    Text("Forgot password?")
                        .foregroundColor(Color.black)
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
                guard let uid = Auth.auth().currentUser?.uid else {return}
                let ref = Database.database().reference().child("users/\(uid)")
                ref.observeSingleEvent(of: .value, with: { snapshot in
                    let postDict = snapshot.value as? [String : AnyObject] ?? [:]
                    
                    if let favorites = postDict["favorites"] {
                        user.favorites = favorites as? [Int] ?? []
                    }
                   
                }) { error in
                    print(error.localizedDescription)
                }
                
                signInProcessing = false
                viewRouter.viewState = .home
            }
        }
    }
}
