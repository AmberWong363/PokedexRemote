//
//  PokedexApp.swift
//  Pokedex
//
//  Created by Amber Wong (student LM) on 1/19/23.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct PokedexApp: App {
    @StateObject var viewRouter : ViewRouter = ViewRouter()
    @StateObject var user : User = User()
    @StateObject var fetchData : FetchData = FetchData()
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            MotherView()
                .environmentObject(user)
                .environmentObject(viewRouter)
                .environmentObject(fetchData)
        }
    }
}
