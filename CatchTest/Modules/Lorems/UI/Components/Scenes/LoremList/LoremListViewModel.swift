//
//  LoremListViewModel.swift
//  CatchTest
//
//  Created by Adonis Dumadapat on 6/22/22.
//

import Foundation

class LoremListViewModel: LoremListViewModelProtocol {
  private(set) var lorems: [Lorem] = []

  private let service: LoremsServiceProtocol

  init() {
    service = LoremsService(api: APIClient())
  }
}

// MARK: - Methods

extension LoremListViewModel {
  func fetchLorems(
    onSuccess: @escaping VoidResult,
    onError: @escaping ErrorResult
  ) {
    service.fetchLorems(
      onSuccess: handleFetchLoremsSuccess(then: onSuccess),
      onError: onError
    )
  }

  func loremCellViewModel(for index: Int) -> LoremCellViewModelProtocol {
    LoremCellViewModel(lorem: lorems[index])
  }

  func loremDetailsViewModel(for index: Int) -> LoremDetailsViewModelProtocol {
    LoremDetailsViewModel(lorem: lorems[index])
  }
}

// MARK: - Handlers

extension LoremListViewModel {
  func handleFetchLoremsSuccess(
    then onComplete: @escaping VoidResult
  ) -> SingleResult<[Lorem]> {
    return { [weak self] response in
      guard let self = self else { return }
      self.lorems = response
      onComplete()
    }
  }
}

// MARK: - Getters

extension LoremListViewModel {
  var loremCount: Int { lorems.count }
  var isEmptyState: Bool { lorems.count == 0 }
}
