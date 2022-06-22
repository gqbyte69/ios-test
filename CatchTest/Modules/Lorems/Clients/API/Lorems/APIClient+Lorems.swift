//
//  APIClient+Lorems.swift
//  CatchTest
//
//  Created by Adonis Dumadapat on 6/22/22.
//

//import Alamofire
import Foundation

extension APIClient: LoremsAPI {
  @discardableResult
  func getLorems(
    onSuccess: @escaping SingleResult<[Lorem]>,
    onError: @escaping ErrorResult
  ) -> RequestProtocol {
    return request(
      "data.json",
      parameters: params,
      success: decodeModel(
        onSuccess: onSuccess,
        onError: onError
      ),
      failure: onError
    )
  }
}
