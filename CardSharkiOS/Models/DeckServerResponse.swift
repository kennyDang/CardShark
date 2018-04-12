//
//  NewDeck.swift
//  CardSharkiOS
//
//  Created by Kenny Dang on 4/11/18.
//

import Foundation

struct DeckServerResponse: Codable {
    var shuffled: Bool
    var remaining: Int
    var deckID: String
    var success: Bool
    
    enum CodingKeys: String, CodingKey {
        case shuffled = "shuffled"
        case remaining = "remaining"
        case deckID = "deck_id"
        case success = "success"
    }
}
