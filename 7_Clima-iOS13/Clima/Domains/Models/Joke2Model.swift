//
//  JokeModel.swift
//  Clima
//
//  Created by 大西志織 on 2025/03/27.
//  Copyright © 2025 App Brewery. All rights reserved.
//

import Foundation

protocol Joke2ModelProtocol {
    func callJoke2(completed: @escaping (_ result: Joke2Entity?, _ error: ErrorCode?) -> Void)
}

protocol Joke2ModelDelegate {
    
}

class Joke2Model: Joke2ModelProtocol {
    
    private var Joke2Service: Joke2ServiceProtocol
    var Joke2: Joke2Entity?
    
    required init(service: Joke2ServiceProtocol) {
        self.Joke2Service = service
    }
    
    func callJoke2(completed: @escaping (Joke2Entity?, ErrorCode?) -> Void) {
        let param = Joke2Request.init()
        Joke2Service.callJoke2(param: param, completed:  { (Joke2Entity, error) in
            self.Joke2 = Joke2Entity
            completed(Joke2Entity, error)
        })
    }

}
