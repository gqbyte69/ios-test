//
//  MockLoremsAPI.swift
//  CatchTestTests
//
//  Created by Adonis Dumadapat on 6/23/22.
//

import Foundation

@testable import CatchTest

class MockLoremsAPI: LoremsAPI {
  var errorToReturn: Error?

  private(set) var getLoremsCallCount: Int = 0
}

// MARK: - Methods

extension MockLoremsAPI {
  func getLorems(
    onSuccess: @escaping SingleResult<[Lorem]>,
    onError: @escaping ErrorResult
  ) {
    getLoremsCallCount += 1
    if let e = errorToReturn {
      onError(e)
    } else {
      onSuccess([])
    }
  }
}
