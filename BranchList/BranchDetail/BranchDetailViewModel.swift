//
//  BranchDetailViewModel.swift
//  BranchList
//
//  Created by Samet Çeviksever on 15.04.2019.
//  Copyright © 2019 Samet Çeviksever. All rights reserved.
//

import UIKit

public struct BranchDetailViewModel {
  private let cellId = "cellId"
  public var branch: Branch
  private var sections: [Branch.Grouped]
  
  public init(branch: Branch) {
    self.branch = branch
    self.sections = branch.groupedInfo()
  }
  
  public func configure(controller: BranchDetailVC) {
    controller.title = branch.name
    controller.tableView.registerCell(type: BranchDetailTVC.self)
  }
  
  public func sectionCount() -> Int {
    return sections.count
  }
  
  public func rowCount(at section: Int) -> Int {
    return sections[section].infos.count
  }
  
  public func headerText(at section: Int) -> String? {
    return sections[section].title
  }
  
  public func dequeCell(from tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
    let cell: BranchDetailTVC = tableView.dequeueReusableCell(forIndexPath: indexPath)
    let info = sections[indexPath.section].infos[indexPath.row]
    cell.configure(with: info)
    
    return cell
  }
}
