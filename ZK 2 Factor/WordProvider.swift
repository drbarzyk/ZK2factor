//
//  WordProvider.swift
//  Wordle
//
//  Created by Mischa Hildebrand on 17.01.22.
//

import Foundation

struct WordProvider {
    
    static let allowedWords: [String] = ["hacks"]
    
    static func generateWord() -> String {
        Self.allowedWords.randomElement()!
    }
    
}
