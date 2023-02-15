//
//  FetchData.swift
//  Pokedex
//
//  Created by Amber Wong (student LM) on 1/19/23.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase

class FetchData : ObservableObject {
    @Published var response : Response = Response()
    @Published var pokeResponses : [PokemonResponse] = []
    @Published var pokeFavorites : [PokemonResponse] = []
    @Published var region : String = "kanto"
    @Published var pokemonId : String = ""
    
    func getData(completion: () -> Void) async {
        
        /*
         The Pokedex URL
         */
        let URLString = "https://pokeapi.co/api/v2/pokedex/\(region)/"
        
        /*
         Making string into URL, returning if error
         */
        guard let url = URL(string: URLString) else {
            print("oops")
            return
        }

        /*
         Do Catch loop, catch errors while parsing data
         */
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            response = try JSONDecoder().decode(Response.self, from: data)
            
            /*
             For loop to get individual pokemon
             */
            for i in 0..<response.pokemon_entries.count {
                pokemonId = response.pokemon_entries[i].pokemon_species.url
                await getPokemonData()
            }
            
        } catch {
            print(error)
        }
        completion()
    }
    
    // Get pokemon Data, too much for my braincell rn
    func getPokemonData() async {
        let URLString = "https://pokeapi.co/api/v2/pokemon/\(clipUrl(str: pokemonId))/"
        
        guard let url = URL(string: URLString) else {
            print("oops")
            return
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            pokeResponses.append(try JSONDecoder().decode(PokemonResponse.self, from: data))
        } catch {
            print(error)
        }
    }
    
    func getFavoritesData(list : [Int], completion: () -> Void) async {
        for i in 0..<list.count {
            pokemonId = String(list[i])
            await getPokemonData()
        }
    }
    
    func clipUrl(str : String) -> String {
        if str.count > 42 {
            var s = str.substring(from: 42, to: str.count)
            s.remove(at: s.lastIndex(of: "/")!)
            return s
        } else {
            return str
        }
    }
    
    
}
