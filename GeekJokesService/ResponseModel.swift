//
//  GeekJokesResponseModel.swift
//  GeekJokes
//
//  Created by Vishal, Bhogal (B.) on 16/04/22.
//

import Foundation

struct FactsResponseModel: Codable {
    let fact: String
    
    enum CodingKeys: String, CodingKey {
        case fact = "joke"
    }
}
