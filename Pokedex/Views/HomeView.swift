//
//  HomeView.swift
//  Pokedex
//
//  Created by Amber Wong (student LM) on 2/8/23.
//

import SwiftUI
import FirebaseAuth

struct HomeView: View {
    
    @EnvironmentObject var user : User
    @EnvironmentObject var viewRouter : ViewRouter
    @EnvironmentObject var fetchData : FetchData
    @State var selection : [String] = ["kanto", "original-johto", "updated-hoenn", "original-sinnoh", "updated-unova", "kalos-coastal", "kalos-mountain", "kalos-central", "updated-alola", "galar", "paldea"]
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color.red)
                .ignoresSafeArea()
            
            Rectangle()
                .foregroundColor(Color.white.opacity(0.3))
                .ignoresSafeArea()
            
            // Actual stuffs
            // Previous things are background
            VStack {
                Text("POKEDEX")
                    .bold()
                    .padding()
                    .foregroundColor(Color.black)
                
                Image("RotomDex")
                    .resizable()
                    .frame(width: 200, height: 200, alignment: .center)
                    .aspectRatio(contentMode: .fill)
                    .padding()
                
                Picker("Dexes", selection: $fetchData.region) {
                    ForEach(selection, id: \.self) { index in
                        Text("\(index)")
                            .accentColor(Color.black)
                    }
                }
                .accentColor(Color.black)
                
                // Goes to dex page
                Button {
                    viewRouter.viewState = .pokedex
                } label: {
                    Text("Go to PokeDex")
                        .padding()
                        .foregroundColor(Color.black)
                        .background(Color.gray.opacity(0.3))
                        .cornerRadius(20)
                }
                .buttonStyle(.plain)
                .padding()

                Spacer()
                
                HStack {
                    Spacer()
                    // Space swooosh
                    //
                    // Lol
                    Button {
                        try! Auth.auth().signOut()
                        
                        user.username = ""
                        user.password = ""
                        user.isLoggedIn = false
                        
                        viewRouter.viewState = .auth
                    } label: {
                        Text("Sign Out")
                            .bold()
                            .padding()
                            .background(Color.gray.opacity(0.3))
                            .cornerRadius(10)
                    }
                    .buttonStyle(.plain)
                    .padding()

                }
            }
        }
    }
}
