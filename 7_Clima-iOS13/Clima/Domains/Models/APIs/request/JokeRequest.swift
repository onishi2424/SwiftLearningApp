//
//  JokeRequest.swift
//  Clima
//
//  Created by 大西志織 on 2025/03/27.
//  Copyright © 2025 App Brewery. All rights reserved.
//

import Foundation

struct Joke2Request: RouterProtocol2 {
    var endpoint: Endpoint = .joke
    var parameterize: Params?
}
