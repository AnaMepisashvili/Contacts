//
//  TableViewController.swift
//  Contacts
//
//  Created by Ana Mepisashvili on 03.12.21.
//

import UIKit

enum Cell: String {
    case phoneCell = "PhoneTableViewCell"
    case notesCell = "NotesTableViewCell"
    case shareCell = "ShareTableViewCell"
    case emergencyCell = "EmergencyTableViewCell"
    case locationCell = "LocationTableViewCell"
    case blockCell = "BlockTableViewCell"
}
// MARK: - TableView Controller, ScrollViewContained

class TableViewController: UITableViewController, ScrollViewContained {
    
    var contact: Contact?
    
    weak var scrollDelegate: ScrollViewContainingDelegate?
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollDelegate?.scrollViewDidScroll(scrollView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
    }
    
    private func config() {
        self.tableView.separatorColor = .clear
        
        tableView.register(PhoneTableViewCell.self, forCellReuseIdentifier: "PhoneTableViewCell")
        tableView.register(NotesTableViewCell.self, forCellReuseIdentifier: "NotesTableViewCell")
        tableView.register(EmergencyTableViewCell.self, forCellReuseIdentifier: "EmergencyTableViewCell")
        tableView.register(LocationTableViewCell.self, forCellReuseIdentifier: "LocationTableViewCell")
        tableView.register(BlockTableViewCell.self, forCellReuseIdentifier: "BlockTableViewCell")
        //        tableView.register(ShareTableViewCell.self, forCellReuseIdentifier: "ShareTableViewCell")
        let nib = UINib(nibName: "ShareTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "ShareTableViewCell")
        
        //        let nib1 = UINib(nibName: "PhoneTableViewCell", bundle: nil)
        //        let nib2 = UINib(nibName: "NotesTableViewCell", bundle: nil)
        
        //        let nib4 = UINib(nibName: "EmergencyTableViewCell", bundle: nil)
        //        let nib5 = UINib(nibName: "LocationTableViewCell", bundle: nil)
        //        let nib6 = UINib(nibName: "BlockTableViewCell", bundle: nil)
        
        //        tableView.register(nib1, forCellReuseIdentifier: "PhoneTableViewCell")
        //        tableView.register(nib2, forCellReuseIdentifier: "NotesTableViewCell")
        //        tableView.register(nib4, forCellReuseIdentifier: "EmergencyTableViewCell")
        //        tableView.register(nib5, forCellReuseIdentifier: "LocationTableViewCell")
        //        tableView.register(nib6, forCellReuseIdentifier: "BlockTableViewCell")
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell?
        switch indexPath.row {
        case 0:
            cell = tableView.dequeueReusableCell(withIdentifier: Cell.phoneCell.rawValue, for: indexPath) as? PhoneTableViewCell
            (cell as? PhoneTableViewCell)?.configure(contact: contact!)
        case 1:
            cell = tableView.dequeueReusableCell(withIdentifier: Cell.notesCell.rawValue, for: indexPath) as? NotesTableViewCell
        case 2:
            cell = tableView.dequeueReusableCell(withIdentifier: Cell.shareCell.rawValue, for: indexPath)
        case 3:
            cell = tableView.dequeueReusableCell(withIdentifier: Cell.emergencyCell.rawValue, for: indexPath)
        case 4:
            cell = tableView.dequeueReusableCell(withIdentifier: Cell.locationCell.rawValue, for: indexPath)
        case 5:
            cell = tableView.dequeueReusableCell(withIdentifier: Cell.blockCell.rawValue, for: indexPath)
        default:
            return UITableViewCell()
        }
        
        cell?.selectionStyle = .none
        cell?.contentView.backgroundColor = .clear
        cell?.backgroundColor = .clear
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0 :
            return 70
        case 1 :
            return 120
        case 2 :
            return 175
        case 3 :
            return 60
        case 4 :
            return 60
        case 5 :
            return 60
        default:
            return .zero
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
}
