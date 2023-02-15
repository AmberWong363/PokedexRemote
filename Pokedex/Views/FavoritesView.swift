//
//  FavoritesView.swift
//  Pokedex
//
//  Created by Amber Wong (student LM) on 2/10/23.
//

import SwiftUI
import FirebaseDatabase

struct FavoritesView: View {
    @EnvironmentObject var fetchData : FetchData
    @EnvironmentObject var viewRouter : ViewRouter
    @EnvironmentObject var user : User
    @State var processing : Bool = true
    
    var body: some View {
        ZStack {
            
            Rectangle()
                .foregroundColor(Color.red)
                .ignoresSafeArea()
                .task {
                    await fetchData.getFavoritesData(list: user.favorites) {
                        processing = false
                    }
                }
            
            Rectangle()
                .foregroundColor(Color.white.opacity(0.3))
                .ignoresSafeArea()
            
            VStack {
                if (processing) {
                    LoadingView()
                } else {
                    HStack {
                        Text("Favorites")
                            .font(Font.custom("title", size: 24))
                            .foregroundColor(Color.black)
                            .padding(.horizontal)
                        Spacer()
                        Button {
                            // Restore favorites in database
                            
                            
                            // Extras
                            processing = false
                            fetchData.pokeFavorites = []
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
                                ForEach(fetchData.pokeFavorites.indices, id: \.self) { index in
                                    NavigationLink {
                                        PokedexDetailView(pokemonResponse: $fetchData.pokeFavorites[index])
                                    } label: {
                                        HStack {
                                            PokedexSimpleView(pokemonResponse: $fetchData.pokeResponses[index], num: Binding.constant(index + 1))
                                            
                                            Button {
                                                user.favorites.append(fetchData.pokeResponses[index].id)
                                            } label: {
                                                Image(systemName: "\(user.favorites.contains(fetchData.pokeResponses[index].id) ? "star" : "star.fill")")
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
}
