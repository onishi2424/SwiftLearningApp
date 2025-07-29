//
//  APIConstants.swift
//  Clima
//
//  Created by 大西志織 on 2025/07/24.
//  Copyright © 2025 App Brewery. All rights reserved.
//

import Alamofire
import Foundation

protocol APIConstants {
    static var baseURL: String { get }
    
    var apiUrl: URL { get }
    var apiPath: String { get }
    var parameters: Parameters? { get }
    var method: HTTPMethod { get }
    var httpHeader: HTTPHeaders { get }
    var timeout: TimeInterval { get }
}

extension APIConstants {
    var apiUrl: URL {
        URL(string: Self.baseURL + apiPath)!
    }
    
    var defaultHeader: HTTPHeaders {
        ["Content-Type": "application/json"]
    }
    
    var httpHeader: HTTPHeaders {
        defaultHeader
    }
    
    var encoding: ParameterEncoding {
        switch method {
        case .post, .put:
            return JSONEncoding.default
        default:
            return URLEncoding.default
        }
    }
    
    var timeout: TimeInterval {
        TimeInterval(20)
    }
    
    func asURLRequest() -> URLRequest {
        var request = URLRequest(url: self.apiUrl)
        request.httpMethod = self.method.rawValue
        self.httpHeader.forEach { header in
            request.setValue(header.value, forHTTPHeaderField: header.name)
        }
        request.timeoutInterval = timeout
        
        if let parameters = parameters {
            do {
                request = try encoding.encode(request, with: parameters)
            } catch {
                print("DomainLayerError: Failed JSON encoding")
            }
        }
        return request
    }
}
