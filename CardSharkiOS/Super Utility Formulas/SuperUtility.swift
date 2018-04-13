//
//  SuperSort.swift
//  CardSharkiOS
//
//  Created by Kenny Dang on 4/12/18.
//

import Foundation

//enum Suits: Int {
//    case queen = 12
//    case king = 13
//    case ace = 1
//    case jack = 11
//}

enum Value: String {
    case queen = "QUEEN"
    case king = "KING"
    case ace = "ACE"
    case jack = "JACK"
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case ten = "10"
    
    var numericValue: Int {
        switch self {
        case .queen:
            return 12
        case .ace:
            return 1
        case .jack:
            return 11
        case .king:
            return 13
        case .one:
            return 1
        case .two:
            return 2
        case .three:
            return 3
        case .four:
            return 4
        case .five:
             return 5
        case .six:
            return 6
        case .seven:
            return 7
        case .eight:
            return 8
        case .nine:
            return 9
        case .ten:
            return 10
        }
        
    }
}

struct SuperUtility {
    static var shared = SuperUtility()
    
    func sort(_ cards: [Card]) -> [Card] {
        let clubs = cards.filter { $0.suit == "CLUBS" }
        let hearts = cards.filter { $0.suit == "HEARTS" }
        let spades = cards.filter { $0.suit == "SPADES" }
        let diamonds = cards.filter { $0.suit == "DIAMONDS" }
        let combined = clubs + hearts + spades + diamonds
        return combined
    }
    
    // This seems extremely hacky but I believe that it works
    func findPairs(_ cards: [Card], sumValue: Int) -> [[String: String]]? {
        var pairs = [[String: String]]()
        for i in 0..<cards.count {
            for j in 1..<cards.count {
                guard let first = Value(rawValue: cards[i].value) else { return nil }
                guard let second = Value(rawValue: cards[j].value) else { return nil }
                
                if first.numericValue + second.numericValue == 13 {
                    if cards[i].suit == "SPADES" || cards[i].suit == "CLUBS" {
                        var pair = [String: String]()
                        pair[cards[i].code] = cards[j].code
                        pairs.append(pair)
                        continue
                    }
                }
            }
        }
        
        return pairs
    }
}
