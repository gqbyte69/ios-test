//
//  LoremDetailsController.swift
//  CatchTest
//
//  Created by Adonis Dumadapat on 6/22/22.
//

import UIKit

class LoremDetailsController: UIViewController {
  var viewModel: LoremDetailsViewModelProtocol!

  @IBOutlet private(set) var detailsLabel: UILabel!
}

// MARK: - Lifecycle

extension LoremDetailsController {
  override func viewDidLoad() {
    super.viewDidLoad()

    setup()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.setNavigationBarHidden(false, animated: false)
  }
}

// MARK: - Setup

private extension LoremDetailsController {
  func setup() {
    title = viewModel.titleText
    detailsLabel.text = viewModel.detailText
  }
}
