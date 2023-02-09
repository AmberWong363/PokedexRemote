//
//  AuthenticationHomeView.swift
//  Pokedex
//
//  Created by Amber Wong (student LM) on 2/8/23.
//

import SwiftUI

struct AuthenticationHomeView: View {
    
    @EnvironmentObject var viewRouter : ViewRouter
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color.red)
                .ignoresSafeArea()
            
            Rectangle()
                .foregroundColor(Color.white.opacity(0.3))
                .ignoresSafeArea()
            
            VStack {
                Image("RotomDex")
                    .resizable()
                    .frame(width: 200, height: 200, alignment: .center)
                    .aspectRatio(contentMode: .fill)
                    .padding()
                HStack {
                    // Sign In View
                    Button {
                        viewRouter.viewState = .signUp
                    } label: {
                        Text("Sign Up")
                            .padding()
                            .background(Color.white.opacity(0.3))
                            .cornerRadius(20)
                    }
                    
                    Button {
                        viewRouter.viewState = .signIn
                    } label: {
                        Text("Sign In")
                            .padding()
                            .background(Color.white.opacity(0.3))
                            .cornerRadius(20)
                    }

                }
            }
        }
    }
}
