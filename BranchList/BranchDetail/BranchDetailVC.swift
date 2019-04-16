//
//  BranchDetailVC.swift
//  BranchList
//
//  Created by Samet Çeviksever on 15.04.2019.
//  Copyright © 2019 Samet Çeviksever. All rights reserved.
//

import UIKit

public class BranchDetailVC: UIViewController, Reusable {
  
  public static func create(with branch: Branch) -> BranchDetailVC {
    let vc = BranchDetailVC(bundle: nil)
    let viewModel = BranchDetailViewModel(branch: branch)
    vc.viewModel = viewModel
    
    return vc
  }
  
  @IBOutlet weak var tableView: UITableView!
  
  fileprivate var viewModel: BranchDetailViewModel!
  
  override public func viewDidLoad() {
    super.viewDidLoad()
    viewModel.configure(controller: self)
  }
  
  override public func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
  }
}

extension BranchDetailVC: UITableViewDataSource {
  public func numberOfSections(in tableView: UITableView) -> Int {
    return viewModel.sectionCount()
  }
  
  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.rowCount(at: section)
  }
  
  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = viewModel.dequeCell(from: tableView, at: indexPath)
    
    return cell
  }
  
  public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return viewModel.headerText(at: section)
  }
}

extension BranchDetailVC: UITableViewDelegate {
  
  public func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    return -1
  }
  
  public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return -1
  }
}
