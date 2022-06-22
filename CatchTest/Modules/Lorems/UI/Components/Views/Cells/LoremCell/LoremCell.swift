//
//  LoremCell.swift
//  CatchTest
//
//  Created by Adonis Dumadapat on 6/22/22.
//

import UIKit

class LoremCell: UITableViewCell {
  var viewModel: LoremCellViewModelProtocol! {
    didSet {
      refresh()
    }
  }

  @IBOutlet private(set) var titleLabel: UILabel!
  @IBOutlet private(set) var subtitleLabel: UILabel!
}

// MARK: - Refresh

private extension LoremCell {
  func refresh() {
    guard viewModel != nil else { return }
    titleLabel.text = viewModel.titleText
    subtitleLabel.text = viewModel.subtitleText
  }
}
