//
//  LocalService.swift
//  Clima
//
//  Created by 大西志織 on 2025/03/27.
//  Copyright © 2025 App Brewery. All rights reserved.
//

import Foundation

protocol LocalServiceProtocol {
    var delegate: LocalServiceDelegate? { get set }
    func callLocal(param: LocalRequest, completed: @escaping (_ result: LocalEntity?, _ error: ErrorCode?) -> Void)
}

protocol LocalServiceDelegate {
    
}

class LocalService: APIService2, LocalServiceProtocol {
    var delegate: LocalServiceDelegate?
    
    func callLocal(param: LocalRequest, completed: @escaping (_ result: LocalEntity?, _ error: ErrorCode?) -> Void) {
        sendRequest(param,
                    LocalEntity.self,
                    successHandler: {(entity: LocalEntity) in
                        completed(entity, nil)
        }) { (error) in
            completed(nil, error)
        }
    }
    
    
}
