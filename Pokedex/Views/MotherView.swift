//
//  MotherView.swift
//  Pokedex
//
//  Created by Amber Wong (student LM) on 2/8/23.
//

import SwiftUI

struct MotherView: View {
    
    @EnvironmentObject var viewRouter : ViewRouter
    @EnvironmentObject var user : User
    
    var body: some View {
        if (viewRouter.viewState == .auth && !user.isLoggedIn) {
            AuthenticationHomeView()
        } else if (viewRouter.viewState == .signIn) {
            SignInView()
        } else if (viewRouter.viewState == .signUp) {
            SignUpView()
        } else if (viewRouter.viewState == .passReset) {
            PasswordResetView()
        } else if (user.isLoggedIn) {
            if (viewRouter.viewState == .pokedex) {
                ContentView()
            } else if (viewRouter.viewState == .favorites) {
                FavoritesView()
            } else {
                HomeView()
            }
        } else {
            LoadingView()
        }
    }
}

