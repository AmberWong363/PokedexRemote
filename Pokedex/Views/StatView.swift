//
//  StatView.swift
//  Pokedex
//
//  Created by Amber Wong (student LM) on 1/26/23.
//

import SwiftUI

struct StatView: View {
    
    @Binding var stats : [Stats]
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color.gray)
            HStack {
                // HP
                VStack {
                    Spacer()
                    Text("\(stats[0].base_stat)")
                        .font(Font.custom("kshfga", size: 10))
                        .padding()
                    Rectangle()
                        .foregroundColor(Color.red)
                        .frame(width: 30, height: CGFloat(integerLiteral: stats[0].base_stat))
                }
                // ATK
                VStack {
                    Spacer()
                    Text("\(stats[1].base_stat)")
                        .font(Font.custom("kshfga", size: 10))
                        .padding()
                    Rectangle()
                        .foregroundColor(Color.red)
                        .frame(width: 30, height: CGFloat(integerLiteral: stats[1].base_stat))
                }
                // DEF
                VStack {
                    Spacer()
                    Text("\(stats[2].base_stat)")
                        .font(Font.custom("kshfga", size: 10))
                        .padding()
                    Rectangle()
                        .foregroundColor(Color.red)
                        .frame(width: 30, height: CGFloat(integerLiteral: stats[2].base_stat))
                }
                // SP ATK
                VStack {
                    Spacer()
                    Text("\(stats[3].base_stat)")
                        .font(Font.custom("kshfga", size: 10))
                        .padding()
                    Rectangle()
                        .foregroundColor(Color.red)
                        .frame(width: 30, height: CGFloat(integerLiteral: stats[3].base_stat))
                }
                // SP DEF
                VStack {
                    Spacer()
                    Text("\(stats[4].base_stat)")
                        .font(Font.custom("kshfga", size: 10))
                        .padding()
                    Rectangle()
                        .foregroundColor(Color.red)
                        .frame(width: 30, height: CGFloat(integerLiteral: stats[4].base_stat))
                }
                // SPD
                VStack {
                    Spacer()
                    Text("\(stats[5].base_stat)")
                        .font(Font.custom("kshfga", size: 10))
                        .padding()
                    Rectangle()
                        .foregroundColor(Color.red)
                        .frame(width: 30, height: CGFloat(integerLiteral: stats[5].base_stat))
                }
            }
        }
    }
}
