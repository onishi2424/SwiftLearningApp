//
//  WeatherAPIContants.swift
//  Clima
//
//  Created by 大西志織 on 2025/07/24.
//  Copyright © 2025 App Brewery. All rights reserved.
//

import Foundation
import Dependencies
import Alamofire

struct WeatherClient {
    var getJoke: @Sendable () async throws -> ResponseJoke
}

extension WeatherClient: DependencyKey {
    static let liveValue = Self(
        getJoke: {
            let request = try JokeAPIConstants.getJoke.asURLRequest()

            do {
                let (data, response) = try await URLSession.shared.data(for: request)
                let decodedResponse = try JSONDecoder().decode(ResponseJoke.self, from: data)
                return decodedResponse
            } catch {
                throw error
            }
        }
    )
}

extension DependencyValues {
    var weatherClient: WeatherClient {
        get { self[WeatherClient.self] }
        set { self[WeatherClient.self] = newValue }
    }
}
