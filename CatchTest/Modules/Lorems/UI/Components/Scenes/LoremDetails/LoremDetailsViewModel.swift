//
//  LoremDetailsViewModel.swift
//  CatchTest
//
//  Created by Adonis Dumadapat on 6/22/22.
//

import Foundation

class LoremDetailsViewModel: LoremDetailsViewModelProtocol {
  private let detail: String

  init(detail: String) {
    self.detail = detail
  }
}

// MARK: - Getters

extension LoremDetailsViewModel {
  var detailText: String { detail }
}
