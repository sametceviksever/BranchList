//
//  UIViewExtension.swift
//  BranchList
//
//  Created by Samet Çeviksever on 15.04.2019.
//  Copyright © 2019 Samet Çeviksever. All rights reserved.
//

import UIKit

public extension Reusable where Self: UIViewController {
  init(bundle: Bundle?) {
    self.init(nibName: Self.reuseIdentifier, bundle: bundle)
  }
}
