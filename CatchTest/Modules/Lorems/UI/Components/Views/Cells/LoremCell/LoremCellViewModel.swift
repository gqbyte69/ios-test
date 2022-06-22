//
//  LoremCellViewModel.swift
//  CatchTest
//
//  Created by Adonis Dumadapat on 6/22/22.
//

import Foundation

class LoremCellViewModel: LoremCellViewModelProtocol {
  private let lorem: Lorem

  init(lorem: Lorem) {
    self.lorem = lorem
  }
}

// MARK: - Getters

extension LoremCellViewModel {
  var titleText: String { lorem.title }
  var subtitleText: String { lorem.subtitle }
}
