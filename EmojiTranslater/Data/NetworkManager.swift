//
//  NetworkManager.swift
//  EmojiTranslater
//
//  Created by Антон Бобрышев on 30.08.2021.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchEmoji() -> NSDictionary {
        
        let urlString  = "https://raw.githubusercontent.com/integer256/emojimap/master/EmojiMap/EmojiMap/EmojiDataBase.bundle/emojis-en.json"
        
        guard let url = URL(string: urlString) else {return [:]}
        guard let emojiData = try? Data(contentsOf: url) else { return [:]}
        let emojiJson = try? JSONSerialization.jsonObject(with: emojiData, options: [])
        guard let emojiDictionary = emojiJson as? NSDictionary else {
            print("error")
            return [:]
        }
        return emojiDictionary
    }

    func WordToEmojiMapping() -> [String : [String]] {
        
        var emojiMap: [String : [String]] = [:]
        
        for (key, value) in fetchEmoji() {
            if let key = key as? String,
               let dictionary = value as? Dictionary<String, AnyObject>,
               
               let emojiCharacter = dictionary["char"] as? String {
                addKey(key, value: emojiCharacter, atBeginning: true)
                if let keywords = dictionary["keywords"] as? [String] {
                    for keyword in keywords {
                        addKey(keyword.lowercased(), value: emojiCharacter, atBeginning: false)
                    }
                }
            }
        }
        
        func addKey(_ key: String, value: String, atBeginning: Bool) {
            if emojiMap[key] == nil {
                emojiMap[key] = []
            }
            if atBeginning {
                emojiMap[key]?.insert(value, at: 0)
            } else {
                emojiMap[key]?.append(value)
            }
        }
        return emojiMap
    }
}
