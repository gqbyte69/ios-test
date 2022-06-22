//
//  LoremsServiceProtocol.swift
//  CatchTest
//
//  Created by Adonis Dumadapat on 6/23/22.
//

import Foundation

protocol LoremsServiceProtocol {
  func fetchLorems(
    onSuccess: @escaping SingleResult<[Lorem]>,
    onError: @escaping ErrorResult
  )
}
