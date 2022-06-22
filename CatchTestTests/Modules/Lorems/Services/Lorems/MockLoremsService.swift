//
//  MockLoremsService.swift
//  CatchTestTests
//
//  Created by Adonis Dumadapat on 6/23/22.
//

import Foundation

@testable import CatchTest

class MockLoremsService: LoremsServiceProtocol {
  var errorToReturn: Error?

  private(set) var fetchLoremsCallCount: Int = 0
}

// MARK: - Methods

extension MockLoremsService {
  func fetchLorems(
    onSuccess: @escaping SingleResult<[Lorem]>,
    onError: @escaping ErrorResult
  ) {
    fetchLoremsCallCount += 1

    if let e = errorToReturn {
      onError(e)
    } else {
      onSuccess([])
    }
  }
}
