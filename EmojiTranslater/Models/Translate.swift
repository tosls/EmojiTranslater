//
//  Translate.swift
//  EmojiTranslater
//
//  Created by Антон Бобрышев on 30.08.2021.
//

import Foundation

struct Translation {
    
    let word: String
    let emoji: String
 
    init(word: String, emoji: String) {
        self.word = word
        self.emoji = emoji
    }
}
