//
//  JokeModel.swift
//  Clima
//
//  Created by 大西志織 on 2025/07/24.
//  Copyright © 2025 App Brewery. All rights reserved.
//

import Foundation
import Dependencies

@MainActor
final class NewJokeViewModel: ObservableObject {
    var jokeText: String?
    var alertMessage: String?
    
    @Dependency(\.weatherClient) var weatherClient
    
//    func fetchJoke() async throws -> ResponseJoke {
//        let response = try await weatherClient.getJoke()
//        return response
//    }
//    
    func fetchJoke() async {
        do {
            let response = try await weatherClient.getJoke()
            jokeText = response.joke
        } catch {
            alertMessage = error.localizedDescription
            print("fetchJoke error:", error)
        }
    }
}
