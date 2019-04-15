//
//  BranchTVC.swift
//  BranchList
//
//  Created by Samet Çeviksever on 14.04.2019.
//  Copyright © 2019 Samet Çeviksever. All rights reserved.
//

import UIKit

public class BranchTVC: UITableViewCell, Reusable {
  
  @IBOutlet weak var lblName: UILabel!
  @IBOutlet weak var lblAddress: UILabel!
  @IBOutlet weak var lblAlias: UILabel!
  
  public func configure(with bankLocation: Branch) {
    lblName.text = bankLocation.name
    lblAddress.text = bankLocation.address
    lblAlias.backgroundColor = bankLocation.type.backgroundColor
    lblAlias.text = bankLocation.type.alias
  }
}
