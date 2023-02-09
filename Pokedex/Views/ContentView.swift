//
//  ContentView.swift
//  Pokedex
//
//  Created by Amber Wong (student LM) on 1/19/23.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var fetchData : FetchData
    @EnvironmentObject var viewRouter : ViewRouter
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color.red)
                .ignoresSafeArea()
                .task {
                    await fetchData.getData()
                }
            Rectangle()
                .foregroundColor(Color.white.opacity(0.3))
                .ignoresSafeArea()
            
            VStack {
                if (fetchData.isProcessing) {
                    LoadingView()
                } else {
                    HStack {
                        Text("\(fetchData.response.name.capitalized) Dex")
                            .font(Font.custom("title", size: 24))
                            .foregroundColor(Color.black)
                            .padding(.horizontal)
                        Spacer()
                        Button {
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
                                        PokedexSimpleView(pokemonResponse: $fetchData.pokeResponses[index], num: Binding.constant(index + 1))
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
