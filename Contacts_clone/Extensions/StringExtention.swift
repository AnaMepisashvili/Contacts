//
//  StringExtention.swift
//  Contacts_clone
//
//  Created by Ana Mepisashvili on 07.12.21.
//

import UIKit

// MARK: - UIImage Extension

extension String {
    var image: UIImage? {
        let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        let nameLabel = UILabel(frame: frame)
        nameLabel.textAlignment = .center
        nameLabel.backgroundColor = .lightGray
        nameLabel.textColor = .white
        nameLabel.font = UIFont.boldSystemFont(ofSize: 40)
        let splitted = self.split(separator: " ")
        var text = ""
        for item in splitted {
            text += "\(item.first!)"
        }
        nameLabel.text = self.isEmpty ? "" : "\(text)"
        UIGraphicsBeginImageContext(frame.size)
        if let currentContext = UIGraphicsGetCurrentContext() {
            nameLabel.layer.render(in: currentContext)
            let nameImage = UIGraphicsGetImageFromCurrentImageContext()
            return nameImage
        }
        return nil
    }
    var startsWithAsciiLetter: Bool { first?.isAsciiLetter == true }
}

extension Character {
    var isAsciiLetter: Bool { "A"..."Z" ~= self || "a"..."z" ~= self }
}
