//
//  UITableViewExtension.swift
//  BranchList
//
//  Created by Samet Çeviksever on 15.04.2019.
//  Copyright © 2019 Samet Çeviksever. All rights reserved.
//

import UIKit

extension UITableView {
  
  public func registerCell<T: UITableViewCell>(type: T.Type) where T: Reusable {
    self.register(UINib(nibName: T.reuseIdentifier, bundle: nil), forCellReuseIdentifier: T.reuseIdentifier)
    
  }
  
  public func dequeueReusableCell<T: UITableViewCell> (forIndexPath indexPath: IndexPath) -> T where T: Reusable {
    return dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath as IndexPath) as! T
  }
  
  public func setEmptyMessage(title: String, message: String, refreshHandler: (()-> ())?) {
    
    let view = EmptyState()
    self.backgroundView = view;
    view.configure(title: title, message: message)
    view.refreshButtonTapped = refreshHandler
    view.sizeToFit()
  }
  
  public func hideEmptyCells() {
    tableFooterView = UIView(frame: .zero)
  }
  
  public func restore() {
    self.backgroundView = nil
  }
}
