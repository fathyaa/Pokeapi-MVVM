//
//  PokemonModel.swift
//  Pokeapi-MVVM
//
//  Created by Phincon on 17/03/23.
//

import Foundation

struct PokemonModel: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [Results]
}

struct Results: Codable {
    let name: String
    let url: String
    
    enum CodingKeys: String, CodingKey{
        case name = "name"
        case url = "url"
    }
}
