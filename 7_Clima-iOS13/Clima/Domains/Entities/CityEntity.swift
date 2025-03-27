//
//  CityEntity.swift
//  Clima
//
//  Created by 大西志織 on 2025/03/27.
//  Copyright © 2025 App Brewery. All rights reserved.
//

import Foundation

struct CityEntity: BaseResponse, Decodable {
    let name: String?
    let main: Main?
    let weather: [Weather]?

    var cityName: String? { name }
    var conditionId: Int? { weather?.first?.id }
    var temperature: Double? { main?.temp }

    struct Main: Decodable {
        let temp: Double?
    }

    struct Weather: Decodable {
        let id: Int?
    }
    
    var temperatureString: String? {
        return String.init(format: "%.1f", temperature ?? 0.0)
    }
    
    var conditionName: String? {
        // docs https://openweathermap.org/weather-conditions
        switch (conditionId ?? 0)/100 {
        case 2:
            return "cloud.bolt"
        case 3:
            return "cloud.drizzle"
        case 5:
            return "cloud.rain"
        case 6:
            return "cloud.snow"
        case 7:
            return "cloud.fog"
        case 8:
            if conditionId == 800 {
                return "sun.max"
            } else {
                return "cloud.bolt"
            }
        default:
            return "cloud"
        }
    }
}
