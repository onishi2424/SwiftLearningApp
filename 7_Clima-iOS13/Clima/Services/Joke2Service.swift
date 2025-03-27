//
//  JokeService.swift
//  Clima
//
//  Created by 大西志織 on 2025/03/27.
//  Copyright © 2025 App Brewery. All rights reserved.
//

import Foundation

protocol Joke2ServiceProtocol {
    var delegate: Joke2ServiceDelegate? { get set }
    func callJoke2(param: Joke2Request, completed: @escaping (_ result: Joke2Entity?, _ error: ErrorCode?) -> Void)
}

protocol Joke2ServiceDelegate {
    
}

class Joke2Service: APIService2, Joke2ServiceProtocol {
    var delegate: Joke2ServiceDelegate?
    
    func callJoke2(param: Joke2Request, completed: @escaping (_ result: Joke2Entity?, _ error: ErrorCode?) -> Void) {
        sendRequest2(param,
                    Joke2Entity.self,
                    successHandler: {(entity: Joke2Entity) in
                        completed(entity, nil)
        }) { (error) in
            completed(nil, error)
        }
    }
}
