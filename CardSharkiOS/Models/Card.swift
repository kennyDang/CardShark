//
//  Card.swift
//  CardSharkiOS
//
//  Created by Kenny Dang on 4/11/18.
//

import UIKit

struct Card: Codable {
    var imageURLString: String
    var value: String
    var suit: String
    var code: String
    
    enum CodingKeys: String, CodingKey {
        case imageURLString = "image"
        case value = "value"
        case suit = "suit"
        case code = "code"
    }
}
