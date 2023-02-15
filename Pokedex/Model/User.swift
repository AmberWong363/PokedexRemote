//
//  User.swift
//  Pokedex
//
//  Created by Amber Wong (student LM) on 2/8/23.
//

import Foundation
import FirebaseAuth

class User : ObservableObject {
    @Published var username : String
    @Published var password : String
    @Published var favorites : [Int]
    // Log in
    @Published var isLoggedIn : Bool = false
    
    init (username : String = "", password : String = "", favorites : [Int] = []) {
        self.username = username
        self.password = password
        self.favorites = favorites
        
        Auth.auth().addStateDidChangeListener{ _, user in
            guard let buffer = user else {return}
            
            self.isLoggedIn.toggle()
            self.username = buffer.email ?? ""
        }
    }
}
