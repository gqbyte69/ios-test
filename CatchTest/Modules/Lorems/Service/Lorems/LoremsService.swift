//
//  LoremsService.swift
//  CatchTest
//
//  Created by Adonis Dumadapat on 6/23/22.
//

import Foundation

class LoremsService: LoremsServiceProtocol {
  private let api: LoremsAPI

  init(api: LoremsAPI) {
    self.api = api
  }
}

// MARK: - Methods

extension LoremsService {
  func fetchLorems(
    onSuccess: @escaping SingleResult<[Lorem]>,
    onError: @escaping ErrorResult
  ) {
    api.getLorems(
      onSuccess: onSuccess,
      onError: onError
    )
  }
}
