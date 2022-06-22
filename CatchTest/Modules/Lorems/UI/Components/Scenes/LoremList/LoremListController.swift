//
//  LoremListController.swift
//  CatchTest
//
//  Created by Adonis Dumadapat on 6/22/22.
//

import UIKit

class LoremListController: ViewController {
  var viewModel: LoremListViewModelProtocol!

  @IBOutlet private(set) var tableView: UITableView!

  private var refreshControl: UIRefreshControl!
}

// MARK: - Lifecycle

extension LoremListController {
  override func viewDidLoad() {
    super.viewDidLoad()

    setup()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.setNavigationBarHidden(true, animated: false)
  }
}

// MARK: - Setup

private extension LoremListController {
  func setup() {
    setupCell()
    setupTableView()
  }

  func setupCell() {
    tableView.register(
      UINib(nibName: "LoremCell", bundle: nil),
      forCellReuseIdentifier: "LoremCell"
    )
  }

  func setupTableView() {
    refreshControl = UIRefreshControl()
    refreshControl.addTarget(
      self,
      action: #selector(handlePullToRefresh(_:)),
      for: .valueChanged
    )
    tableView.addSubview(refreshControl)
  }
}

// MARK: - Router

private extension LoremListController {
  func navigateToLoremDetails(vm: LoremDetailsViewModelProtocol) {
    let sb = UIStoryboard(name: "LoremDetails", bundle: nil)
    let vc: LoremDetailsController = sb.instantiateViewController(withIdentifier: "LoremDetailsController") as! LoremDetailsController
    vc.viewModel = vm
    navigationController?.pushViewController(vc, animated: true)
  }
}

// MARK: - Event Handlers

private extension LoremListController {
  @objc
  func handlePullToRefresh(_ sender: AnyObject) {
    viewModel.fetchLorems(
      onSuccess: handleFetchLoremsSuccess(),
      onError: handleError()
    )
  }

  func handleFetchLoremsSuccess() -> VoidResult {
    return { [weak self] in
      guard let self = self else { return }
    }
  }

  func handleError() -> ErrorResult {
    return { error in
      print(String(describing: error))
    }
  }
}

// MARK: - Helpers

private extension LoremListController {
}

// MARK: - UITableViewDataSource

extension LoremListController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    viewModel.loremCount
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard
      let cell = tableView.dequeueReusableCell(
        withIdentifier: "LoremCell"
      ) as? LoremCell
    else {
      preconditionFailure("Dequeued cell is not an instance of LoremCell")
    }
    cell.viewModel = viewModel.loremCellViewModel(for: indexPath.row)
    return cell
  }
}

// MARK: - UITableViewDelegate

extension LoremListController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let vm = viewModel.loremDetailsViewModel(for: indexPath.row)
    navigateToLoremDetails(vm: vm)
    tableView.deselectRow(at: indexPath, animated: true)
  }
}
