//
//  ResponseJoke.swift
//  Clima
//
//  Created by 大西志織 on 2025/07/24.
//  Copyright © 2025 App Brewery. All rights reserved.
//

struct ResponseJoke: Decodable, Sendable {
    let id: String
    let joke: String
    let status: Int
}

