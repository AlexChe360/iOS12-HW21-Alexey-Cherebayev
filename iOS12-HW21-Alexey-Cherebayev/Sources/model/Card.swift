//
//  Card.swift
//  iOS12-HW21-Alexey-Cherebayev
//
//  Created by Alex on 05.04.2024.
//

import Foundation

struct Cards: Decodable {
    let cards: [Card]?
    
    enum CodingKeys: String, CodingKey {
        case cards = "cards"
    }
}

struct Card: Decodable {
    let name: String?
    let type: String?
    let manaCost: String?
    let setName: String?
    let imageUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case name = "name",
             type = "type",
             manaCost = "manaCost",
             setName = "setName",
             imageUrl = "imageUrl"
    }
}
