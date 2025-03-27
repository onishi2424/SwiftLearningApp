//
//  ErrorCode.swift
//  Clima
//
//  Created by 大西志織 on 2025/03/27.
//  Copyright © 2025 App Brewery. All rights reserved.
//

import Foundation

struct ErrorCode: Error {
  let errorCode: String?
  let errorKey: [String]?
  let errorMessage: [String]?

  init(errorCode: String?, errorKey: [String]?, errorMessage: [String]?) {
    self.errorCode = errorCode
    self.errorKey = errorKey
    self.errorMessage = errorMessage
  }
}
