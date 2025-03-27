////
////  JokeDataManager.swift
////  Clima
////
////  Created by 大西志織 on 2025/01/1.
////  Copyright © 2025 App Brewery. All rights reserved.
////
//
//import Foundation
//
//protocol JokeManagerDelegate {
//    func updateJoke(jokeModel: JokeModel)
//    func failedWithError(error: Error)
//}
//
//struct JokeDataManater {
//    let baseURL = "https://icanhazdadjoke.com/"
//    
//    var delegate: JokeManagerDelegate?
//    
//    func performRequest(url: String){
//        // 1. Create URL
//        if let url = URL(string: url){          // URL initializer create optional URL
//            var request = URLRequest(url: url)
//            request.setValue("application/json", forHTTPHeaderField: "Accept") // JSONレスポンスを要求
//            
//            // 2. Create URL Session
//            let session = URLSession(configuration: .default)
//            
//            // 3. Give the session with task
//            let task = session.dataTask(with: request) { (data, response, error) in
//                // if error exists
//                if error != nil{
//                    self.delegate?.failedWithError(error: error!)
//                    return
//                }
//                
//                // Decode JSON
//                if let safeData = data{
//                    // "self" is necessery in closure
//                    if let jokeStr = self.parseJSON(jokeData: safeData) {
//                        self.delegate?.updateJoke(jokeModel: jokeStr)
//                    }
//                }
//            }
//
//            // what task do: go to url -> grab data -> come back
//            
//            // 4. Start the task
//            task.resume()
//        }
//    }
//    
//    func parseJSON(jokeData: Data) -> JokeModel? {
//        let decoder = JSONDecoder()
//        do{
//            let decodedData = try decoder.decode(JokeData.self, from: jokeData)
//            print("decoded: \(decodedData)")
//            
//            return JokeModel(joke: decodedData.joke)
//            
//        }catch {
//            delegate?.failedWithError(error: error)
//            return nil
//        }
//    }
//}
//
