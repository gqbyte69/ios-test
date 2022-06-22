//
//  LoremDetailsViewModel.swift
//  CatchTest
//
//  Created by Adonis Dumadapat on 6/22/22.
//

import Foundation

class LoremDetailsViewModel: LoremDetailsViewModelProtocol {
  private let lorem: Lorem

  init(lorem: Lorem) {
    self.lorem = lorem
  }
}

// MARK: - Getters

extension LoremDetailsViewModel {
  var titleText: String { lorem.title }
  var detailText: String { lorem.content }
}
