//
//  Constants.swift
//  Pokedex
//
//  Created by Amber Wong (student LM) on 1/19/23.
//

import Foundation

extension String {
    func substring(from: Int, to: Int) -> String {
        let start = self.index(self.startIndex, offsetBy: from)
        let end = self.index(self.startIndex, offsetBy: to)
        let range = start..<end
        return String(self[range])
    }
}

enum viewRouter {
    case page1
    case page2
}
