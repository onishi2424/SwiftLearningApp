//
//  APIService2.swift
//  Clima
//
//  Created by 大西志織 on 2025/03/27.
//  Copyright © 2025 App Brewery. All rights reserved.
//

import Foundation
import Alamofire
import UIKit

let networkErrorCodeTimeout = "network_error_code_timeout"
let networkErrorCodeStock = "network_error_code_stock"


// MARK: - Implementation
class APIService2 {
    
    // ※※※※※ クラス変数にdecoderを追加 ※※※※※
    let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    // ※※※※※ ※※※※※ ※※※※※ ※※※※※ ※※※※※ ※※※※※
    
    func sendRequest<T:BaseResponse>(_ router: RouterProtocol,
                                     _ type: T.Type,
                                     successHandler: @escaping(T)->(),
                                     failHandler: @escaping(ErrorCode?)->()) {
        // ネットワークに繋がっていなかったら、そもそもアクセスできないのでエラーとする。
        if !(NetworkReachabilityManager.default?.isReachable ?? false) {
            failHandler(ErrorCode(errorCode: "エラー", errorKey: [""], errorMessage: ["ネットワークエラーが発生しました。"]))
            return
        }
        
        guard var request = try? router.asURLRequest() else {
            failHandler(ErrorCode(errorCode: "エラー", errorKey: [""], errorMessage: ["ネットワークエラーが発生しました。"]))
            print("エラー, 999")
            return
        }
        
        request.timeoutInterval = 180
        
        print("AF.request start")
        if false {
            AF.request(request)
                .responseString { result in
                    
                    
                    print(">> result: \(result)")
                    
                    
                }
        }else{
            AF.request(request)
                .responseDecodable(of: T.self, decoder: self.decoder) { (response: AFDataResponse<T>) in
                    switch response.result {
                    case .success:
                        guard let data = response.data else {
                            print("AF.request failure response.data")
                            failHandler(ErrorCode(errorCode: "エラー", errorKey: [""], errorMessage: [ErrorInit,"\n(response.data)"]))
                            return
                        }
                        
                        // ※※※※※ (一応)クラス変数のdecoderを使ってデコードする
                        guard let model = try? self.decoder.decode(T.self, from: data) else {
                            print("AF.request failure jsonDecoder.decode")
                            failHandler(ErrorCode(errorCode: "エラー", errorKey: [""], errorMessage: [ErrorInit,"\n(jsonDecoder.decode)"]))
                            return
                        }
                        
                        //            // 処理結果コードがsuccess以外はエラー。
                        //            if !(model.apiStatus! == statusSuccess) {
                        //              print("AF.request failure model.getErrorCode() \(String(describing: model.apiStatus))")
                        //              failHandler(self.getErrorCodeOnError(model))
                        //              return
                        //            }
                        
                        print("AF.request success")
                        successHandler(model)
                    case .failure(let error):
                        let afErr = error.asAFError?.underlyingError as? NSError
                        if let under_error = afErr?.code {
                            if under_error == NSURLErrorTimedOut {
                                failHandler(ErrorCode(errorCode: "エラー", errorKey: [""], errorMessage: ["タイムアウトエラーが発生しました。"]))
                                return
                            }
                        }
                        
                        if let errorDescription = error.errorDescription {
                            print(errorDescription)
                        }
                        if let responseCode = error.responseCode {
                            print("AF.request failure responseCode \(responseCode)")
                        }
                        failHandler(ErrorCode(errorCode: "エラー", errorKey: [""], errorMessage: ["ネットワークエラーが発生しました。"]))
                    }
                }
        }
    }
    
    func sendRequest2<T:BaseResponse>(_ router: RouterProtocol2,
                                     _ type: T.Type,
                                     successHandler: @escaping(T)->(),
                                     failHandler: @escaping(ErrorCode?)->()) {
        // ネットワークに繋がっていなかったら、そもそもアクセスできないのでエラーとする。
        if !(NetworkReachabilityManager.default?.isReachable ?? false) {
            failHandler(ErrorCode(errorCode: "エラー", errorKey: [""], errorMessage: ["ネットワークエラーが発生しました。"]))
            return
        }
        
        guard var request = try? router.asURLRequest() else {
            failHandler(ErrorCode(errorCode: "エラー", errorKey: [""], errorMessage: ["ネットワークエラーが発生しました。"]))
            print("エラー, 999")
            return
        }
        
        request.timeoutInterval = 180
        
        print("AF.request start")
        if false {
            AF.request(request)
                .responseString { result in
                    
                    
                    print(">> result: \(result)")
                    
                    
                }
        }else{
            AF.request(request)
                .responseDecodable(of: T.self, decoder: self.decoder) { (response: AFDataResponse<T>) in
                    switch response.result {
                    case .success:
                        guard let data = response.data else {
                            print("AF.request failure response.data")
                            failHandler(ErrorCode(errorCode: "エラー", errorKey: [""], errorMessage: [ErrorInit,"\n(response.data)"]))
                            return
                        }
                        
                        // ※※※※※ (一応)クラス変数のdecoderを使ってデコードする
                        guard let model = try? self.decoder.decode(T.self, from: data) else {
                            print("AF.request failure jsonDecoder.decode")
                            failHandler(ErrorCode(errorCode: "エラー", errorKey: [""], errorMessage: [ErrorInit,"\n(jsonDecoder.decode)"]))
                            return
                        }
                        
                        //            // 処理結果コードがsuccess以外はエラー。
                        //            if !(model.apiStatus! == statusSuccess) {
                        //              print("AF.request failure model.getErrorCode() \(String(describing: model.apiStatus))")
                        //              failHandler(self.getErrorCodeOnError(model))
                        //              return
                        //            }
                        
                        print("AF.request success")
                        successHandler(model)
                    case .failure(let error):
                        let afErr = error.asAFError?.underlyingError as? NSError
                        if let under_error = afErr?.code {
                            if under_error == NSURLErrorTimedOut {
                                failHandler(ErrorCode(errorCode: "エラー", errorKey: [""], errorMessage: ["タイムアウトエラーが発生しました。"]))
                                return
                            }
                        }
                        
                        if let errorDescription = error.errorDescription {
                            print(errorDescription)
                        }
                        if let responseCode = error.responseCode {
                            print("AF.request failure responseCode \(responseCode)")
                        }
                        failHandler(ErrorCode(errorCode: "エラー", errorKey: [""], errorMessage: ["ネットワークエラーが発生しました。"]))
                    }
                }
        }
    }
}
