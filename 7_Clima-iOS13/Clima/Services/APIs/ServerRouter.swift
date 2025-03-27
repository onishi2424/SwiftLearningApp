//
//  ServerRouter.swift
//  Clima
//
//  Created by 大西志織 on 2025/03/27.
//  Copyright © 2025 App Brewery. All rights reserved.
//

import Foundation

import Alamofire

typealias Params = [String: Any]

// MARK: - Enum
fileprivate enum ApiConst {
  fileprivate enum HeaderKeys: String {
    case accessToken = "X-ACCESS-TOKEN",
       os = "X-OS",
       osVersion = "X-OS-VERSION",
       appVersion = "X-APP-VERSION"
  }

    static func getDomainPath(endpoint: Endpoint) -> String {
        let path: String
        switch endpoint {
        case .joke:
            path = "icanhazdadjoke.com"
        case .weather:
            path = "api.openweathermap.org"
        }
    /*
     true : 通常使用(devdelop:開発 Release:本番)
     false: 本番データをデバッグする用(強制本番接続)

     ！！ 注意 ！！
     false状態でコミットしないこと！！！
    */
    if (true) {
      if isDevelop(){
        return Domain.develop.rawValue + path
      } else {
        return Domain.develop.rawValue + path
      }
    }else{
      return Domain.develop.rawValue + path
    }
  }
}

/**
 エンドポイント名。
 */
enum Endpoint: String {
    case joke = "/"
    case weather = "/data/2.5/weather"
}

/**
 リクエストパラメータの定義。
 */
protocol Parameterizable {
  var parameterize: Params? { get }
}

/**
 APIアクセスに必要なプロトコル定義。
 */
protocol RouterProtocol: Parameterizable, URLRequestConvertible {
  var endpoint: Endpoint { get }
}

protocol RouterProtocol2: Parameterizable, URLRequestConvertible {
  var endpoint: Endpoint { get }
}

extension RouterProtocol {
  /**
   URLRequestConvertibleの固定の実装。
    */
    public func asURLRequest() throws -> URLRequest {
    let param: Params = [:]

        let url = URL(string: ApiConst.getDomainPath(endpoint: .weather))!
    var urlRequest = URLRequest(url: url.appendingPathComponent(endpoint.rawValue))
    urlRequest.httpMethod = HTTPMethod.get.rawValue
    do {
      // ヘッダをセットする。
      var httpHeaders = HTTPHeaders.init(dictionaryLiteral:
                        ("X-APP-VERSION", Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String),
                        ("X-OS", UIDevice.current.systemName),
                        ("X-OS-VERSION", UIDevice.current.systemVersion),
                        ("Content-Type", "application/json"),
                        ("User-Agent", "vehicle_registration"),
                        ("If-Modified-Since", ""))

      httpHeaders.add(name: "Authorization", value: "J3lw9FDJBPQXh5V6xi6L3QP67OL8qmGy9Ap241y9n4Y9hr6KisaBel9H94oChUl0")

      urlRequest.headers = httpHeaders

      // パラメータを追加する。
      var parameter: Params = param
      if let parameterize = parameterize {
        parameter = param.union(other: parameterize)
      }

      // httpBody にパラメータをセットする。
//      urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameter)
      urlRequest = try URLEncoding.default.encode(urlRequest, with: parameter)

    } catch {
      print(error)
    }

    return urlRequest
  }
}

extension RouterProtocol2 {
  /**
   URLRequestConvertibleの固定の実装。
    */
    public func asURLRequest() throws -> URLRequest {
    let param: Params = [:]

    let url = URL(string: ApiConst.getDomainPath(endpoint: .joke))!
    var urlRequest = URLRequest(url: url.appendingPathComponent(endpoint.rawValue))
    urlRequest.httpMethod = HTTPMethod.get.rawValue
    do {
      // ヘッダをセットする。
      var httpHeaders = HTTPHeaders.init(dictionaryLiteral:
                        ("X-APP-VERSION", Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String),
                        ("X-OS", UIDevice.current.systemName),
                        ("X-OS-VERSION", UIDevice.current.systemVersion),
                        ("Content-Type", "application/json"),
                        ("User-Agent", "vehicle_registration"),
                        ("If-Modified-Since", ""),
                        ("Accept", "application/json"))

      httpHeaders.add(name: "Authorization", value: "J3lw9FDJBPQXh5V6xi6L3QP67OL8qmGy9Ap241y9n4Y9hr6KisaBel9H94oChUl0")

      urlRequest.headers = httpHeaders

      // パラメータを追加する。
      var parameter: Params = param
      if let parameterize = parameterize {
        parameter = param.union(other: parameterize)
      }

      // httpBody にパラメータをセットする。
//      urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameter)
      urlRequest = try URLEncoding.default.encode(urlRequest, with: parameter)

    } catch {
      print(error)
    }

    return urlRequest
  }
}
