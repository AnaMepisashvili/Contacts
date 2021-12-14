//
//  EmergencyTableViewCell.swift
//  Contacts
//
//  Created by Ana Mepisashvili on 02.12.21.
//

import UIKit

class EmergencyTableViewCell: UITableViewCell {
    
    lazy var EmergencyLabel: UILabel = {
        let width = contentView.bounds.width * 0.8
        let height = contentView.bounds.height * 0.3
        let x: CGFloat = 10
        let y: CGFloat = 12
        let frame = CGRect(x: x, y: y, width: width, height: height)
        
        let label = UILabel(frame: frame)
        let font = UIFont(name: "Arial", size: 17)
        label.font = font
        label.text = "Add to Emergency Contacts"
        label.textColor = .systemBlue
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.addSubview(EmergencyLabel)
        let margins = UIEdgeInsets(top: 5, left: 8, bottom: 10, right: 8)
        contentView.frame = contentView.frame.inset(by: margins)
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 10
    }
    
}
