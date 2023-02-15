//
//  PasswordResetView.swift
//  Pokedex
//
//  Created by Amber Wong (student LM) on 2/10/23.
//

import SwiftUI
import FirebaseAuth

struct PasswordResetView: View {
    @EnvironmentObject var viewRouter : ViewRouter
    @State var email : String = ""
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color.red)
                .ignoresSafeArea()
            
            Rectangle()
                .foregroundColor(Color.white.opacity(0.3))
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    Button {
                        viewRouter.viewState = .auth
                    } label: {
                        Text("Back")
                            .padding()
                            .foregroundColor(Color.black)
                    }
                    
                    Spacer()
                    
                }
                Spacer()
                TextField("emailish", text: $email, prompt: Text("email"))
                    .padding()
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .background(Color.white.opacity(0.3))
                    .cornerRadius(20)
                    .padding()
                
                Button {
                    try! Auth.auth().sendPasswordReset(withEmail: email)
                } label: {
                    Text("Send Code")
                        .padding()
                        .background(Color.white.opacity(0.3))
                        .cornerRadius(20)
                        .buttonStyle(.plain)
                }
                Spacer()
            }
        }
    }
}
