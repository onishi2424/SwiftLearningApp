//
//  CityService.swift
//  Clima
//
//  Created by 大西志織 on 2025/03/27.
//  Copyright © 2025 App Brewery. All rights reserved.
//

import Foundation

protocol CityServiceProtocol {
    var delegate: CityServiceDelegate? { get set }
    func callCity(param: CityRequest, completed: @escaping (_ result: CityEntity?, _ error: ErrorCode?) -> Void)
}

protocol CityServiceDelegate {
    
}

class CityService: APIService2, CityServiceProtocol {
    var delegate: CityServiceDelegate?
    
    func callCity(param: CityRequest, completed: @escaping (_ result: CityEntity?, _ error: ErrorCode?) -> Void) {
        sendRequest(param,
                    CityEntity.self,
                    successHandler: {(entity: CityEntity) in
                        completed(entity, nil)
        }) { (error) in
            completed(nil, error)
        }
    }
    
    
}
