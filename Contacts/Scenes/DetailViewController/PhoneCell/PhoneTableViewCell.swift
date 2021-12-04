//
//  PhoneTableViewCell.swift
//  Contacts
//
//  Created by Ana Mepisashvili on 02.12.21.
//

import UIKit

class PhoneTableViewCell: UITableViewCell {
    
    lazy var phoneLabel: UILabel = {
        let width = contentView.bounds.width * 0.2
        let height = contentView.bounds.height * 0.3
        let x: CGFloat = 10
        let y: CGFloat = 8
        let frame = CGRect(x: x, y: y, width: width, height: height)
        let label = UILabel(frame: frame)
        let font = UIFont(name: "Arial", size: 15)
        label.font = font
        label.text = "phone"
        label.textColor = .black
        return label
    }()
    
    lazy var numberLabel: UILabel = {
        let width = contentView.bounds.width * 0.5
        let height = contentView.bounds.height * 0.3
        let x: CGFloat = 10
        let y: CGFloat = phoneLabel.frame.maxY
        let frame = CGRect(x: x, y: y, width: width, height: height)
        let label = UILabel(frame: frame)
        let font = UIFont(name: "Arial", size: 17)
        label.font = font
        label.text = "+995 598 15 15 00"
        label.textColor = .systemBlue
        return label
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.addSubview(phoneLabel)
        contentView.addSubview(numberLabel)
        let margins = UIEdgeInsets(top: 5, left: 8, bottom: 10, right: 8)
        contentView.frame = contentView.frame.inset(by: margins)
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 10
    }
    
}
