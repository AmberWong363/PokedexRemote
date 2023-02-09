//
//  PokedexDetailView.swift
//  Pokedex
//
//  Created by Amber Wong (student LM) on 1/20/23.
//

import SwiftUI
import struct Kingfisher.KFImage

struct PokedexDetailView: View {
    
    @Binding var pokemonResponse : PokemonResponse
    
    var body: some View {
        ZStack {
            Rectangle().fill(LinearGradient(gradient: Gradient(colors: [Color.gray, Color.white, Color.gray]), startPoint: .topLeading, endPoint: .bottomTrailing))
                .ignoresSafeArea()
            
            Rectangle()
                .foregroundColor(Color.white.opacity(0.2))
                .ignoresSafeArea()
            
            ScrollView {
                Text("\(pokemonResponse.id) | \(pokemonResponse.name.capitalized)")
                    .font(Font.custom("bigg", size: 24))
                    .padding([.top, .leading, .trailing])
                
                HStack {
                    KFImage(URL(string: pokemonResponse.sprites.front_default))
                        .resizable()
                        .frame(width: 150, height: 150)
                        .aspectRatio(contentMode: .fit)
                        .padding()
                        
                    if (pokemonResponse.sprites.front_shiny != nil) {
                        KFImage(URL(string: pokemonResponse.sprites.front_shiny ?? ""))
                            .resizable()
                            .frame(width: 150, height: 150)
                            .aspectRatio(contentMode: .fit)
                            .padding()
                    }
                }
                
                Text("Abilities:")
                    .font(Font.custom("hf", size: 24))
                HStack {
                    ForEach(pokemonResponse.abilities.indices, id: \.self) { index in
                        Text("\(pokemonResponse.abilities[index].ability.name)")
                            .font(Font.custom("skjaf", size: 14))
                            .frame(width: 80, height: 35)
                            .background(pokemonResponse.abilities[index].is_hidden ? Color.blue.opacity(0.7) : Color.white.opacity(0.7))
                            .foregroundColor(Color.black)
                            .cornerRadius(10)
                            
                    }
                }
                .padding()
                
                VStack {
                    Text("Moves:")
                        .font(Font.custom("hf", size: 24))
                    ForEach(pokemonResponse.moves.indices, id: \.self) { index in
                        Text("\(pokemonResponse.moves[index].move.name)")
                            .font(Font.custom("skjaf", size: 16))
                            .frame(width: 200, height: 35)
                            .background(Color.white.opacity(0.7))
                            .foregroundColor(Color.black)
                            .cornerRadius(10)
                    }
                }
                .padding(.horizontal)
                
                Text("Stats:")
                    .font(Font.custom("hf", size: 24))
                StatView(stats: $pokemonResponse.stats)
                    .padding()
            }
        }
    }
}
