//
//  ShareTableViewCell.swift
//  Contacts
//
//  Created by Ana Mepisashvili on 04.12.21.
//

import UIKit

class ShareTableViewCell: UITableViewCell {

    @IBOutlet weak var view: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        view.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
