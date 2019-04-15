//
//  BranchDetailTVC.swift
//  BranchList
//
//  Created by Samet Çeviksever on 15.04.2019.
//  Copyright © 2019 Samet Çeviksever. All rights reserved.
//

import UIKit

public class BranchDetailTVC: UITableViewCell, Reusable {

  @IBOutlet weak var lblTitle: UILabel!
  @IBOutlet weak var lblDescriptiom: UILabel!
  
  override public func awakeFromNib() {
      super.awakeFromNib()
      // Initialization code
  }
  
  public func configure(with info: (key: String, value: String)) {
    lblTitle.text = info.key
    lblDescriptiom.text = info.value
  }
}
