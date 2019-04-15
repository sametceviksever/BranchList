//
//  RegionListVC.swift
//  BranchList
//
//  Created by Samet Çeviksever on 14.04.2019.
//  Copyright © 2019 Samet Çeviksever. All rights reserved.
//

import UIKit

public class RegionListVC: UIViewController {
  deinit {
    print("deinit")
  }
  @IBOutlet weak var tableView: UITableView!
  
  fileprivate var viewModel: RegionListViewModel!
  public var refreshController: UIRefreshControl = UIRefreshControl()
  
  override public func viewDidLoad() {
    super.viewDidLoad()
    viewModel = RegionListViewModel(countries: AppHelper.shared.countries)
    viewModel.configure(controller: self)
  }
  
  @objc public func refresh() {
    AppHelper.shared.prepareData(isLaunch: false)
  }
}

extension RegionListVC: UITableViewDataSource {
  public func numberOfSections(in tableView: UITableView) -> Int {
    return viewModel.countries.count
  }
  
  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.regionCount(at: section)
  }
  
  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = viewModel.dequeCell(tableView, at: indexPath)
    return cell
  }
  
  public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    let country = viewModel.country(at: section)
    return country.type.headerString
  }
}

extension RegionListVC: UITableViewDelegate {
  public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let branches = viewModel.getBranches(at: indexPath)
    let region = viewModel.getRegion(at: indexPath)
    let vc = BranchListVC.create(with: branches)
    vc.title = region.name
    navigationController?.pushViewController(vc, animated: true)
  }
}

extension RegionListVC: AppHelperDelegate {
  public func didUpdate(countries: [Country]) {
    refreshController.endRefreshing()
    viewModel = RegionListViewModel(countries: countries)
    tableView.reloadData()
  }
}
