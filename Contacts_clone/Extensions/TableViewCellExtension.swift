//
//  TableViewCellExtension.swift
//  Contacts
//
//  Created by Ana Mepisashvili on 01.12.21.
//

import UIKit

// MARK: - UITableViewCell Extension

extension UITableViewCell {
    
    static var identifier: String {
        return String(describing: self)
    }
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
}

