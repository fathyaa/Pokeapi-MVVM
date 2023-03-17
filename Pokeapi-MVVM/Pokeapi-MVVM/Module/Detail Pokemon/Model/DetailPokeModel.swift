//
//  DetailPokeModel.swift
//  Pokeapi-MVVM
//
//  Created by Phincon on 17/03/23.
//

import Foundation

struct DetailPokeModel: Codable {
    let id: Int
    let name: String
    let sprites: SpritesModel
    var moves: [MovesModel]
}

// sprites
struct SpritesModel: Codable {
    let imageUrl: String
    
    enum CodingKeys: String, CodingKey {
        case imageUrl = "front_default"
    }
}

// moves
struct MovesModel: Codable {
    let move: MoveModel
}

struct MoveModel: Codable {
    let name: String
    let url: String
    var detail: MoveDetailModel?
}

struct MoveDetailModel: Codable {
    let accuracy: Int?
    let effectEntries: [EffectModel]
    
    enum CodingKeys: String, CodingKey {
        case accuracy
        case effectEntries = "effect_entries"
    }
}

struct EffectModel: Codable {
    let effect: String
}
