//
//  LoremService.swift
//  CatchTest
//
//  Created by Adonis Dumadapat on 6/22/22.
//

import Foundation

class LoremService: LoremServiceProtocol {
  private let api: LoremsAPI

  init(api: LoremsAPI) {
    self.api = api
  }
}

// MARK: - Methods

extension LoremService {
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
