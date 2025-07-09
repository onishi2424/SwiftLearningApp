//
//  JokeAPIClient.swift
//  Clima
//
//  Created by 大西志織 on 2025/07/09.
//  Copyright © 2025 App Brewery. All rights reserved.
//

import Foundation
import Dependencies
import Alamofire

struct WeatherAPIClient {
    var getJoke: @Sendable () async throws -> ResJoke
}

extension WeatherAPIClient: DependencyKey {
    static let liveValue = Self(
        getJoke: {
            let request = try WeatherAPIConstants.getJoke.asURLRequest()

            do {
                let data = try await AF.request(request)
                    .serializingDecodable(ResJoke.self)
                    .value
                return data
            } catch {
                // 必要ならログや変換処理もここで追加できる
                throw error
            }
        }
    )
}

extension DependencyValues {
    var WeatherAPIClient: JokeAPIClient {
        get { self[JokeAPIClient.self] }
        set { self[JokeAPIClient.self] = newValue }
    }
}
