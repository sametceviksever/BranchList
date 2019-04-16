//
//  EmptyState.swift
//  BranchList
//
//  Created by Samet Çeviksever on 16.04.2019.
//  Copyright © 2019 Samet Çeviksever. All rights reserved.
//

import UIKit

public class EmptyState: BaseView {
  @IBOutlet weak var lblTitle: UILabel!
  @IBOutlet weak var lblMessage: UILabel!
  
  public var refreshButtonTapped: (() -> ())?
  
  public func configure(title: String, message: String) {
    lblTitle.text = title
    lblMessage.text = message
  }
  
  @IBAction func didTapRefresh() {
    refreshButtonTapped?()
  }
}
