//
//  Untitled.swift
//  Clima
//
//  Created by 大西志織 on 2025/07/24.
//  Copyright © 2025 App Brewery. All rights reserved.
//

import Alamofire
import Foundation

enum JokeAPIConstants: APIConstants {
    case getJoke
    
    static var baseURL: String {
        "https://icanhazdadjoke.com"
    }
    
    var apiPath: String {
        "/"
    }
    
    var parameters: Parameters? {
        nil
    }
    
    var method: HTTPMethod {
        .get
    }
    
    var httpHeader: HTTPHeaders {
        [
            "Accept": "application/json"
        ]
    }
}
