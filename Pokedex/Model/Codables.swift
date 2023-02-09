//
//  Codables.swift
//  Pokedex
//
//  Created by Amber Wong (student LM) on 1/19/23.
//

import Foundation

class Response : Codable {
    var name : String = ""
    var descriptions : [Description] = []
    var pokemon_entries : [DexEntry] = []
}

class DexEntry : Codable {
    var entry_number : Int = 0
    var pokemon_species : PokeSpecies = PokeSpecies()
}

extension DexEntry : Identifiable {
    var id : String {return String(self.entry_number)}
}

class PokeSpecies : Codable {
    var name : String = ""
    var url : String = ""
}

class Description : Codable {
    var description : String = ""
}

/*
 Complicated stuff
 */

class PokemonResponse : Codable {
    var name : String = ""
    var id : Int = 0
    var sprites : Sprite = Sprite()
    var abilities : [Abilities] = []
    var moves : [Moves] = []
    var stats : [Stats] = []
    var types : [Types] = []
}

class Sprite : Codable {
    var front_default : String = ""
    var front_shiny : String? = ""
}

class Abilities : Codable {
    var ability : Ability = Ability()
    var is_hidden : Bool = false
    var slot : Int = 0
}

extension Abilities : Identifiable {
    var id : String {return self.ability.name}
}

class Ability : Codable {
    var name : String = ""
}

class Moves : Codable {
    var move : Move = Move()
}

class Move : Codable {
    var name : String = ""
}

extension Move : Identifiable {
    var id : String {return self.name}
}

class Stats : Codable {
    var base_stat : Int = 0
    var stat : Stat = Stat()
}

class Stat : Codable {
    var name : String = ""
}

class Types : Codable {
    var slot : Int = 0
    var type : Type = Type()
}

class Type : Codable {
    var name : String = ""
}
