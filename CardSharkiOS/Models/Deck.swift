//
//  Deck.swift
//  CardSharkiOS
//
//  Created by Kenny Dang on 4/11/18.
//

import Foundation

class Deck: Codable {
    var success: Bool
    var cards: [Card]
    var deckID: String
    var remaining: Int
    
    init(success: Bool, cards: [Card], deckID: String, remaining: Int) {
        self.success = success
        self.cards = cards
        self.deckID = deckID
        self.remaining = remaining
    }
    
    enum CodingKeys: String, CodingKey {
        case success = "success"
        case cards = "cards"
        case deckID = "deck_id"
        case remaining = "remaining"
    }
}
