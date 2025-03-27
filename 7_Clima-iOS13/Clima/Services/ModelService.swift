//
//  ModelService.swift
//  Clima
//
//  Created by 大西志織 on 2025/03/27.
//  Copyright © 2025 App Brewery. All rights reserved.
//

import Foundation

class ModelService {
    static var shared = ModelService()
    var jokeModel: Joke2Model
    var cityModel: CityModel
    var localModel: LocalModel
    
    private init() {
        jokeModel = Joke2Model.init(service: Joke2Service())
        cityModel = CityModel.init(service: CityService())
        localModel = LocalModel.init(service: LocalService())
    }
}
