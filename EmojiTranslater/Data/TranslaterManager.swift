//
//  TranslateManager.swift
//  EmojiTranslater
//
//  Created by Антон Бобрышев on 31.08.2021.
//

import Foundation

class TranslaterManager {
    
    var emojiDictionary = NetworkManager.shared.WordToEmojiMapping()
    
    func getTranslate(_ inputText: String) -> [Translation] {
        
        var translationResult = [Translation]()
        for word in inputText.lowercased().components(separatedBy: " ") {
            if let matches = emojiDictionary[word] {
                let randomNumber = Int(arc4random_uniform(UInt32(matches.count - 1)))
                let match = Translation(word: word, emoji: matches[randomNumber])
                translationResult.append(match)
            }
        }
        return translationResult
    }
}
