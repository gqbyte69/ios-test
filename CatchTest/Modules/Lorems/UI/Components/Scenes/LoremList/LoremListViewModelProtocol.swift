//
//  LoremListViewModelProtocol.swift
//  CatchTest
//
//  Created by Adonis Dumadapat on 6/22/22.
//

import Foundation

protocol LoremListViewModelProtocol {
  var loremCount: Int { get }
  var isEmptyState: Bool { get }

  func fetchLorems(
    onSuccess: @escaping VoidResult,
    onError: @escaping ErrorResult
  )

  func loremCellViewModel(for index: Int) -> LoremCellViewModelProtocol

  func loremDetailsViewModel(for index: Int) -> LoremDetailsViewModelProtocol
}
