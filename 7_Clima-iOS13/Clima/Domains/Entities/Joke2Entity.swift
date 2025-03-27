//
//  JokeEntity.swift
//  Clima
//
//  Created by 大西志織 on 2025/03/27.
//  Copyright © 2025 App Brewery. All rights reserved.
//

import Foundation

struct Joke2Entity: BaseResponse ,Decodable {
    var status: Int?
    let id: String?
    let joke: String?
}
