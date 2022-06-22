//
//  APIClient+Lorems.swift
//  CatchTest
//
//  Created by Adonis Dumadapat on 6/22/22.
//

import Foundation

extension APIClient: LoremsAPI {
  func getLorems(
    onSuccess: @escaping SingleResult<[Lorem]>,
    onError: @escaping ErrorResult
  ) {
    consumeAPI(
      usingUrl: "data.json",
      withVerb: .get,
      onSuccess: onSuccess,
      onError: onError
    )
  }
}
