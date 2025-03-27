//
//  BaseResponce.swift
//  Clima
//
//  Created by 大西志織 on 2025/03/27.
//  Copyright © 2025 App Brewery. All rights reserved.
//

import Foundation

protocol BaseResponse: Decodable {
//    var message: String? { get set }
//    func isSuccess() -> Bool
//    func isError() -> Bool
//    func getErrorCode() -> Int?
}

//extension BaseResponse {
//    func isSuccess() -> Bool {
//      return status == statusSuccess
//    }
//
//    func isError() -> Bool {
//      return !isSuccess()
//    }
//
//    func getErrorCode() -> Int? {
//      if isError() {
//          return status
//      }
//      return statusSuccess
//    }
//}
