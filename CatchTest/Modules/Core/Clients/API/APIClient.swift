//
//  APIClient.swift
//  CatchTest
//
//  Created by Adonis Dumadapat on 6/22/22.
//

import Alamofire
import Foundation

enum AppError: Error {
  case unknown
}

class APIClient {
  let baseUrl = "https://raw.githubusercontent.com/catchnz/ios-test/master/data/"

  func consumeAPI<T: Codable>(
    usingUrl url: String,
    withVerb restVerb: HTTPMethod,
    withParameters params: [String: Any]? = nil,
    onSuccess: @escaping SingleResult<T>,
    onError: @escaping ErrorResult
  ) {
    let uuid = UUID().uuidString

    if params != nil {
      print("\n\nVERB: [\(restVerb)]\nURL:  [\(baseUrl + url)]\nREQUEST: [\(uuid)]: \nPARAMS:  [\(params!)]\n")
    } else {
      print("\n\nVERB: [\(restVerb)]\nURL:  [\(baseUrl + url)]\nREQUEST: [\(uuid)]: \nPARAMS:  [none]\n")
    }

    Alamofire.request(
      "\(baseUrl)\(url)",
      method: restVerb,
      parameters: params,
      encoding: URLEncoding.default,
      headers: nil
    ).responseJSON(
      completionHandler: handleJSONResponse(
        uuid: uuid,
        onSuccess: onSuccess,
        onError: onError
      )
    )
  }

  func handleJSONResponse<T: Codable>(
    uuid: String,
    onSuccess: @escaping SingleResult<T>,
    onError: @escaping ErrorResult
  ) -> SingleResult<DataResponse<Any>> {
    return { response in
//      let responseDataString = NSString(data: response.data!, encoding: String.Encoding.utf8.rawValue)
//      print("\n\nRESPONSE [\(uuid)]: \n\(responseDataString!)\n")

      switch response.result {
      case .success:
        guard
          let data = response.data
        else {
          onError(AppError.unknown)
          return
        }
        do {
          let resp = try JSONDecoder().decode(T.self, from: data)
          onSuccess(resp)
        } catch let error {
          debugPrint(error)
        }
        break
      case let .failure(error):
        onError(error)
        break
      }
    }
  }
}
