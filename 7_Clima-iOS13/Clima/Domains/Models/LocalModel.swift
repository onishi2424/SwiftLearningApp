//
//  LocalModel.swift
//  Clima
//
//  Created by 大西志織 on 2025/03/27.
//  Copyright © 2025 App Brewery. All rights reserved.
//

import Foundation

protocol LocalModelProtocol {
    func callLocal(lat: Double?, lon: Double? ,completed: @escaping (_ result: LocalEntity?, _ error: ErrorCode?) -> Void)
}

protocol LocalModelDelegate {
    
}

class LocalModel: LocalModelProtocol {
    
    private var localService: LocalServiceProtocol
    var local: LocalEntity?
    
    required init(service: LocalServiceProtocol) {
        self.localService = service
    }
    
    func callLocal(lat: Double?, lon: Double?, completed: @escaping (LocalEntity?, ErrorCode?) -> Void) {
        let param = LocalRequest.init(lat: lat!, lon: lon!)
        
        localService.callLocal(param: param, completed:  { (LocalEntity, error) in
            self.local = LocalEntity
            completed(LocalEntity, error)
        })
    }

}
