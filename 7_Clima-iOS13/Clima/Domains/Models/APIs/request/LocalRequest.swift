//
//  LocalRequest.swift
//  Clima
//
//  Created by 大西志織 on 2025/03/27.
//  Copyright © 2025 App Brewery. All rights reserved.
//

import Foundation

struct LocalRequest: RouterProtocol {
    var endpoint: Endpoint = .weather
    var parameterize: Params?
    
    init(lat: Double, lon: Double) {
        self.parameterize = [
            "appid": "4e415e4ab2aaed09e04d8419beedee19",
            "units": "metric",
            "lat": lat,
            "lon": lon
        ]
    }
    
}
