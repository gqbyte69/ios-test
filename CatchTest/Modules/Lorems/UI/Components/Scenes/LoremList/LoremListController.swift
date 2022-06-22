//
//  LoremListController.swift
//  CatchTest
//
//  Created by Adonis Dumadapat on 6/22/22.
//

import UIKit

class LoremListController: UIViewController {
  var viewModel: LoremListViewModelProtocol!

  @IBOutlet private(set) var emptyStateScrollView: UIScrollView!
  @IBOutlet private(set) var tableView: UITableView!

  private var refreshControl: UIRefreshControl!

  private var emptyStateRefreshControl: UIRefreshControl!
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

//    refreshData()
  }
}

// MARK: - Setup

private extension LoremListController {
  func setup() {
    setupInitialVisibility()
    setupCell()
    setupTableViewRefreshControl()
    setupEmptyStateViewRefreshControl()
  }

  func setupInitialVisibility() {
    emptyStateScrollView.isHidden = false
    tableView.isHidden = true
  }

  func setupCell() {
    tableView.register(
      UINib(nibName: "LoremCell", bundle: nil),
      forCellReuseIdentifier: "LoremCell"
    )
  }

  func setupEmptyStateViewRefreshControl() {
    guard
      let customView = Bundle.main.loadNibNamed(
        "CatchRefreshView",
        owner: nil,
        options: nil
      )
    else {
      return
    }

    guard
      let refreshView = customView[0] as? UIView
    else {
      return
    }

    emptyStateRefreshControl = UIRefreshControl()

    emptyStateRefreshControl.addTarget(
      self,
      action: #selector(handleEmptyStatePullToRefresh(_:)),
      for: .valueChanged
    )
    emptyStateScrollView.addSubview(emptyStateRefreshControl)

    let frame = refreshControl.frame
    refreshView.frame = CGRect(
      origin: frame.origin,
      size: CGSize(
        width: frame.size.width,
        height: 120
      )
    )
    emptyStateRefreshControl.addSubview(refreshView)
  }

  func setupTableViewRefreshControl() {
    guard
      let customView = Bundle.main.loadNibNamed(
        "CatchRefreshView",
        owner: nil,
        options: nil
      )
    else {
      return
    }

    guard
      let refreshView = customView[0] as? UIView
    else {
      return
    }

    refreshControl = UIRefreshControl()
    refreshControl.addTarget(
      self,
      action: #selector(handlePullToRefresh(_:)),
      for: .valueChanged
    )
    tableView.addSubview(refreshControl)

    let frame = refreshControl.frame
    refreshView.frame = CGRect(
      origin: frame.origin,
      size: CGSize(
        width: frame.size.width,
        height: 120
      )
    )
    refreshControl.addSubview(refreshView)
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
  func handleEmptyStatePullToRefresh(_ sender: AnyObject) {
    refreshData()
  }

  @objc
  func handlePullToRefresh(_ sender: AnyObject) {
    refreshData()
  }

  func handleFetchLoremsSuccess() -> VoidResult {
    return { [weak self] in
      guard let self = self else { return }
      self.refreshControl.endRefreshing()
      self.emptyStateRefreshControl.endRefreshing()
      self.tableView.reloadData()
      self.updateVisibility()
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
  func refreshData() {
    viewModel.fetchLorems(
      onSuccess: handleFetchLoremsSuccess(),
      onError: handleError()
    )
  }

  func updateVisibility() {
    tableView.isHidden = viewModel.isEmptyState
    emptyStateScrollView.isHidden = !viewModel.isEmptyState
  }
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
