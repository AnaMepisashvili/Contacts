//
//  NotesTableViewCell.swift
//  Contacts
//
//  Created by Ana Mepisashvili on 02.12.21.
//

import UIKit

class NotesTableViewCell: UITableViewCell {
    
    lazy var noteLabel: UILabel = {
        let width = contentView.bounds.width * 0.2
        let height = contentView.bounds.height * 0.3
        let x: CGFloat = 10
        let y: CGFloat = 8
        let frame = CGRect(x: x, y: y, width: width, height: height)
        let label = UILabel(frame: frame)
        let font = UIFont(name: "Arial", size: 15)
        label.font = font
        label.text = "Note"
        label.textColor = .black
        return label
    }()
    
    lazy var textField: UITextField = {
        let width = contentView.bounds.width * 0.5
        let height = contentView.bounds.height * 0.3
        let x: CGFloat = 10
        let y: CGFloat = noteLabel.frame.maxY
        let frame = CGRect(x: x, y: y, width: width, height: height)
        let txtField = UITextField(frame: frame)
        return txtField
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.addSubview(noteLabel)
        contentView.addSubview(textField)
        let margins = UIEdgeInsets(top: 5, left: 8, bottom: 10, right: 8)
        contentView.frame = contentView.frame.inset(by: margins)
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 10
    }
}
