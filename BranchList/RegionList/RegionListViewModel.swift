//
//  RegionListViewModel.swift
//  BranchList
//
//  Created by Samet Çeviksever on 14.04.2019.
//  Copyright © 2019 Samet Çeviksever. All rights reserved.
//

import UIKit

public class RegionListViewModel {
  var countries: [Country]
  var selectedIndex: IndexPath?
  private let cellId: String = "cell"
  
  public init(countries: [Country]) {
    self.countries = countries
  }
  
  public func configure(controller: RegionListVC) {
    registerCell(to: controller.tableView)
    controller.title = "Regions"
    controller.refreshController.addTarget(controller, action: #selector(controller.refresh), for: .valueChanged)
    controller.tableView.addSubview(controller.refreshController)
    AppHelper.shared.delegate = controller
  }
  
  public func country(at index: Int) -> Country{
    return countries[index]
  }
  
  public func regionCount(at index: Int) -> Int{
    return countries[index].regions.count
  }
  
  public func getRegion(at indexPath: IndexPath) -> Region {
    return countries[indexPath.section].regions[indexPath.row]
  }
  
  public func registerCell(to tableView: UITableView) {
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
  }
  
  public func getBranches(at indexPath: IndexPath) -> [Branch] {
    return countries[indexPath.section].regions[indexPath.row].branches
  }
  
  public func dequeCell(_ tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell{
    let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
    let region = getRegion(at: indexPath)
    cell.textLabel?.text = region.name
    cell.accessoryType = .disclosureIndicator
    
    return cell
  }
}
