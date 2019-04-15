//
//  BranchListVC.swift
//  BranchList
//
//  Created by Samet Çeviksever on 14.04.2019.
//  Copyright © 2019 Samet Çeviksever. All rights reserved.
//

import UIKit

class BranchListVC: UIViewController, Reusable {
  static func create(with branches: [Branch]) -> BranchListVC {
    let vc = BranchListVC(bundle: nil)
    let viewModel = BranchListViewModel(branches: branches)
    vc.viewModel = viewModel
    
    return vc
  }
  
  @IBOutlet weak var tableView: UITableView!
  private var viewModel: BranchListViewModel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel.registerCell(to: tableView)
  }
  
  public override func viewDidAppear(_ animated: Bool) {
    if let indexPath = viewModel.selectedIndex {
      let cell = tableView.cellForRow(at: indexPath)
      cell?.setSelected(false, animated: true)
    }
  }
}

extension BranchListVC: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.branchCount()
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = viewModel.dequeCell(from: tableView, at: indexPath)
    return cell
  }
}

extension BranchListVC: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    viewModel.selectedIndex = indexPath
    let branch = viewModel.getBranch(at: indexPath)
    let vc = BranchDetailVC.create(with: branch)
    navigationController?.pushViewController(vc, animated: true)
  }
}
