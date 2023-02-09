//
//  ViewRouter.swift
//  Pokedex
//
//  Created by Amber Wong (student LM) on 2/8/23.
//

import Foundation

class ViewRouter : ObservableObject {
    @Published var viewState : ViewState = .auth
}

enum ViewState {
    case home
    case signIn
    case signUp
    case auth
    case pokedex
}
