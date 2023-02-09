//
//  PokedexSimpleView.swift
//  Pokedex
//
//  Created by Amber Wong (student LM) on 1/19/23.
//

import SwiftUI
import struct Kingfisher.KFImage

struct PokedexSimpleView: View {
    
    @Binding var pokemonResponse : PokemonResponse
    @Binding var num : Int
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color.gray)
                .cornerRadius(10)
            HStack {
                Text("\(num)")
                    .padding(3)
                KFImage(URL(string: "\(pokemonResponse.sprites.front_default)"))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(1)
                Text("\(pokemonResponse.name)")
                    .padding(1)
            }
            .frame(width: 250, height: 50, alignment: .leading)
        }
        .frame(width: 250, height: 50)
    }
}
