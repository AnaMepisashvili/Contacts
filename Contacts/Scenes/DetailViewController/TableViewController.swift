//
//  TableViewController.swift
//  Contacts
//
//  Created by Ana Mepisashvili on 03.12.21.
//

import UIKit

// MARK: - TableView Controller, ScrollViewContained
class TableViewController: UITableViewController, ScrollViewContained {
    
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
        var cell: UITableViewCell
        switch indexPath.row {
        case 0:
            cell = tableView.dequeueReusableCell(withIdentifier: "PhoneTableViewCell", for: indexPath)
        case 1:
            cell = tableView.dequeueReusableCell(withIdentifier: "NotesTableViewCell", for: indexPath)
        case 2:
            cell = tableView.dequeueReusableCell(withIdentifier: "ShareTableViewCell", for: indexPath)
        case 3:
            cell = tableView.dequeueReusableCell(withIdentifier: "EmergencyTableViewCell", for: indexPath)
        case 4:
            cell = tableView.dequeueReusableCell(withIdentifier: "LocationTableViewCell", for: indexPath)
        case 5:
            cell = tableView.dequeueReusableCell(withIdentifier: "BlockTableViewCell", for: indexPath)
        default:
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        return cell
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
            return UIScreen.main.bounds.height / 15
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
