//
//  ContentView.swift
//  Pokedex
//
//  Created by Amber Wong (student LM) on 1/19/23.
//

import SwiftUI
import FirebaseDatabase
import FirebaseAuth

struct ContentView: View {
    
    @EnvironmentObject var fetchData : FetchData
    @EnvironmentObject var viewRouter : ViewRouter
    @EnvironmentObject var user : User
    @State var isProcessing = true
    
    var body: some View {
        ZStack {
            // BG
            Rectangle()
                .foregroundColor(Color.red)
                .ignoresSafeArea()
                .task {
                    await fetchData.getData() {
                        
                        // UID ACQUIRE
                        guard let uid = Auth.auth().currentUser?.uid else {return}
                        // REFERENCE TO DATABASE
                        let ref = Database.database().reference()
                        // INFO FROM DATABASE
                        ref.child("users").child(uid).observeSingleEvent(of: .value, with: { snapshot in
                            let value = snapshot.value as? NSDictionary
                            let fav = value?["favorites"] as? [Int] ?? [-1]
                            // Equality
                            user.favorites = fav
                        }) { error in
                            print(error.localizedDescription)
                        }
                        isProcessing = false
                    }
                }
            Rectangle()
                .foregroundColor(Color.white.opacity(0.3))
                .ignoresSafeArea()
            // Actual content
            VStack {
                // Make a loading screen while getting data
                if (isProcessing) {
                    LoadingView()
                } else {
                    HStack {
                        // Dex name
                        Text("\(fetchData.response.name.capitalized) Dex")
                            .font(Font.custom("title", size: 24))
                            .foregroundColor(Color.black)
                            .padding(.horizontal)
                        Spacer()
                        Button {
                            isProcessing = true
                            // Store Favorites marked before
                            storeFavorites()
                            // Go back to home page
                            fetchData.pokeResponses = []
                            viewRouter.viewState = .home
                        } label: {
                            Text("Back")
                                .foregroundColor(Color.black)
                                .padding(.horizontal)
                                .buttonStyle(.plain)
                        }

                    }
                    .padding(1)
                    if (fetchData.response.descriptions.count > 0) {
                        HStack {
                            Text("\(fetchData.response.descriptions[0].description)")
                                .font(Font.custom("7ygb", size: 12))
                                .foregroundColor(Color.black)
                                .padding(.horizontal)
                            Spacer()
                            
                        }
                        .padding(1)
                    }
                    /*
                     Uh oh
                     */
                    if fetchData.pokeResponses.count > 0 {
                        NavigationView {
                            ScrollView {
                                /*
                                 For Each Loop
                                 */
                                ForEach(fetchData.pokeResponses.indices, id: \.self) { index in
                                    NavigationLink {
                                        PokedexDetailView(pokemonResponse: $fetchData.pokeResponses[index])
                                    } label: {
                                        HStack {
                                            PokedexSimpleView(pokemonResponse: $fetchData.pokeResponses[index], num: Binding.constant(index + 1))
                                            
                                            Button {
                                                if (user.favorites.contains(fetchData.pokeResponses[index].id)) {
                                                    var index1 = -1
                                                    for i in 0..<user.favorites.count {
                                                        if user.favorites[i] == fetchData.pokeResponses[index].id {
                                                            index1 = i
                                                        }
                                                    }
                                                    user.favorites.remove(at: index1)
                                                } else {
                                                    user.favorites.append(fetchData.pokeResponses[index].id)
                                                }
                                                print(user.favorites)
                                            } label: {
                                                Image(systemName: "\(user.favorites.contains(fetchData.pokeResponses[index].id) ? "star.fill" : "star")")
                                            }

                                        }
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }
                            }
                            .padding(.vertical)
                        }
                    }
                }
            }
        }
    }
    
    func getFavoritesUpdate(completion: () -> Void) -> [Int] {
        guard let uid = Auth.auth().currentUser?.uid else {return [-1]}
        let ref = Database.database().reference().child("users/\(uid)")
        var favs : [Int] = []
        ref.observeSingleEvent(of: .value, with: { snapshot in
            let postDict = snapshot.value as? [String : AnyObject] ?? [:]
            
            if let favorites = postDict["favorites"] {
                favs = favorites as? [Int] ?? [-1]
            }
           
        }) { error in
            print(error.localizedDescription)
        }
        
        completion()
        return favs
    }
    
    func storeFavorites() {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let database = Database.database().reference().child("users/\(uid)/favorites")
        database.setValue(user.favorites)
    }
}
