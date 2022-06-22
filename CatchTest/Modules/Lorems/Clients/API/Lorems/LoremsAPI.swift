//
//  LoremsAPI.swift
//  CatchTest
//
//  Created by Adonis Dumadapat on 6/22/22.
//

import Foundation

protocol LoremsAPI {
  @discardableResult
  func getLorems(
    onSuccess: @escaping SingleResult<[Lorem]>,
    onError: @escaping ErrorResult
  ) -> RequestProtocol
}
