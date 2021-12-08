//
//  DataSource.swift
//  Contacts
//
//  Created by Ana Mepisashvili on 06.12.21.
//

import UIKit

class DataSource: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    var sectionTitle = [String]()
    
    var tableView: UITableView!
    var viewModel: HomeVCViewModelProtocol!
    var navController: UINavigationController!
    var manager = ContactsManager.shared
    var headers: [String] {
        manager.getHeaders()
    }
    var dict: [String: [Contact]] {
        manager.getDict(headers: headers)
    }
    
    init(with tableView: UITableView,
         with viewModel: HomeVCViewModel,
         with navController: UINavigationController) {
        
        super.init()
        
        self.tableView = tableView
        self.viewModel = viewModel
        self.navController = navController
        
        sectionTitle = viewModel.getSectionTitle()
        print("anaaaa \(sectionTitle)")
        configTableView()
//        viewModel.reloadTableView = {
//            self.tableView.reloadData()
//        }
    }
    
    func configTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.sectionHeaderHeight = UITableView.automaticDimension
        self.tableView.registerNib(class: MyProfileTableViewCell.self)
//        self.tableView.registerNib(class: ContactsTableViewCell.self)
        let nib = UINib(nibName: "ContactsTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "ContactsTableViewCell")
        //        self.tableView.sectionHeaderTopPadding = 0.5
        self.tableView.register(UINib(nibName: "ContactsHeaderFooterView", bundle: nil),
                                forHeaderFooterViewReuseIdentifier: "ContactsHeaderFooterView")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return headers.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return dict[headers[section]]!.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "ContactsHeaderFooterView") as? ContactsHeaderFooterView
        if section == 0 {
            return headerView
        } else {
            headerView?.headerTitleLabel.text = headers[section]
            return headerView
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 && indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MyProfileTableViewCell", for: indexPath)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ContactsTableViewCell", for: indexPath) as! ContactsTableViewCell
            cell.contact = dict[headers[indexPath.section]]![indexPath.row]
            return cell
        }
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        sectionTitle
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "DetailViewController", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        let contact = dict[headers[indexPath.section]]![indexPath.row]
        viewController.name = contact.firstName + " " + contact.lastName
        viewController.contact = contact
        navController.pushViewController(viewController, animated: true)
    }
    
}
