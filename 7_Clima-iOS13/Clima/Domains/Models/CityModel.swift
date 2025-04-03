//
//  CityModel.swift
//  Clima
//
//  Created by 大西志織 on 2025/03/27.
//  Copyright © 2025 App Brewery. All rights reserved.
//

import Foundation

protocol CityModelProtocol {
    func callCity(q: String? ,completed: @escaping (_ result: CityEntity?, _ error: ErrorCode?) -> Void)
}

protocol CityModelDelegate {
    
}

class CityModel: CityModelProtocol {
    
    private var cityService: CityServiceProtocol
    var city: CityEntity?
    
    required init(service: CityServiceProtocol) {
        self.cityService = service
    }
    
    func callCity(q: String?, completed: @escaping (CityEntity?, ErrorCode?) -> Void) {
        let param = CityRequest.init(q: q!)
        
        cityService.callCity(param: param, completed:  { (cityEntity, error) in
            self.city = cityEntity
            completed(cityEntity, error)
        })
    }

}
