//
//  HomeTableViewCell.swift
//  Contacts
//
//  Created by Ana Mepisashvili on 01.12.21.
//

import UIKit

class ContactsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var contactLabel: UILabel!
    var contact: Contact?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configure()
    }
    
    func configure() {
        guard let contact = contact else {
            return
        }
        contactLabel.text = (contact.firstName ?? "") + " " + (contact.lastName ?? "")
    }
    
}
