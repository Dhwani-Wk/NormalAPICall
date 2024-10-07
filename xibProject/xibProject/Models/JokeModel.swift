//
//  JokeModel.swift
//  xibProject
//
//  Created by admin on 06/09/24.
//

import Foundation



//Decodable meaning
struct JokeModel: Codable {
    let id: Int
    let type: String
    let setup: String
    let punchline: String
}

