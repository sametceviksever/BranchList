//
//  BranchListViewModel.swift
//  BranchList
//
//  Created by Samet Çeviksever on 15.04.2019.
//  Copyright © 2019 Samet Çeviksever. All rights reserved.
//

import UIKit

public class BranchListViewModel {
  private let cellId: String = "cellId"
  let branches: [Branch]
  
  public init(branches: [Branch]) {
    self.branches = branches
  }
  
  public func registerCell(to tableView: UITableView) {
    tableView.registerCell(type: BranchTVC.self)
  }
  
  public func branchCount() -> Int {
    return branches.count
  }
  
  public func getBranch(at indexPath: IndexPath) -> Branch {
    return branches[indexPath.row]
  }
  
  public func dequeCell(from tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
    let cell: BranchTVC = tableView.dequeueReusableCell(forIndexPath: indexPath)
    let branch = getBranch(at: indexPath)
    cell.configure(with: branch)
    cell.accessoryType = .disclosureIndicator
    
    return cell
  }
}
