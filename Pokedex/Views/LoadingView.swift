//
//  LoadingView.swift
//  Pokedex
//
//  Created by Amber Wong (student LM) on 2/8/23.
//

import SwiftUI

struct LoadingView: View {
    @EnvironmentObject var viewRouter : ViewRouter
    @EnvironmentObject var fetchData : FetchData
    var body: some View {
        ZStack{
            Rectangle()
                .foregroundColor(Color.red)
                .ignoresSafeArea()
            Rectangle()
                .foregroundColor(Color.white.opacity(0.3))
                .ignoresSafeArea()
            
            VStack {
                Text("Please Wait...")
                    .foregroundColor(Color.black)
                    .padding()
                
                ProgressView()
                Button {
                    fetchData.pokeResponses = []
                    viewRouter.viewState = .home
                } label: {
                    Text("Cancel")
                        .foregroundColor(Color.black)
                        .padding()
                }
                .buttonStyle(.plain)

            }
        }
    }
}
