//
//  ViewController.swift
//  Contacts
//
//  Created by Ana Mepisashvili on 01.12.21.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet private var tableView: UITableView!
    
    
    var contactDict = [String : [String]]()
    
    private var contactNames = [String]()
    
    var sectionTitle = [String]()
    
    var contacts = [Contact(name: "Ana Gogia", image: "", mobile: "", notes: "", email: ""),
                    Contact(name: "Ani Sikharulidze", image: "", mobile: "", notes: "", email: ""),
                    Contact(name: "Ano Ghudushauri", image: "", mobile: "", notes: "", email: ""),
                    Contact(name: "Bakhva Jakeli", image: "", mobile: "", notes: "", email: ""),
                    Contact(name: "Beqa Gogokhia", image: "", mobile: "", notes: "", email: ""),
                    Contact(name: "Daria Eristavi", image: "", mobile: "", notes: "", email: ""),
                    Contact(name: "Deda", image: "", mobile: "", notes: "", email: ""),
                    Contact(name: "Diana Pipinashvili", image: "", mobile: "", notes: "", email: ""),
                    Contact(name: "Ebo Qemoklidze", image: "", mobile: "", notes: "", email: ""),
                    Contact(name: "Giorgi Digmelashvili", image: "", mobile: "", notes: "", email: ""),
                    Contact(name: "Giorgi Dvali", image: "", mobile: "", notes: "", email: ""),
                    Contact(name: "Giorgi Gogava", image: "", mobile: "", notes: "", email: ""),
                    Contact(name: "Giorgi Gonjilashvili", image: "", mobile: "", notes: "", email: ""),
                    Contact(name: "Ia Sepiashvili", image: "", mobile: "", notes: "", email: ""),
                    Contact(name: "Ilia Malazonia", image: "", mobile: "", notes: "", email: ""),
                    Contact(name: "Irakli", image: "", mobile: "", notes: "", email: ""),
                    Contact(name: "Irina Gurgenidze", image: "", mobile: "", notes: "", email: ""),
                    Contact(name: "Juba(პერემიჩკები)", image: "", mobile: "", notes: "", email: ""),
                    Contact(name: "Keta Bulalauri", image: "", mobile: "", notes: "", email: ""),
                    Contact(name: "Kakha Arabidze", image: "", mobile: "", notes: "", email: ""),
                    Contact(name: "Lado Tsivtsivadze", image: "", mobile: "", notes: "", email: ""),
                    Contact(name: "Lasha Chantladze", image: "", mobile: "", notes: "", email: ""),
                    Contact(name: "Levan Xoxashvili", image: "", mobile: "", notes: "", email: ""),
                    Contact(name: "Ma", image: "", mobile: "", notes: "", email: ""),
                    Contact(name: "Mikheil Chikviladze", image: "", mobile: "", notes: "", email: ""),
                    Contact(name: "Natalia", image: "", mobile: "", notes: "", email: ""),
                    Contact(name: "Nikoloz Chanturia", image: "", mobile: "", notes: "", email: ""),
                    Contact(name: "Otar Khachapuridze", image: "", mobile: "", notes: "", email: ""),
                    Contact(name: "Pikinesa", image: "", mobile: "", notes: "", email: ""),
                    Contact(name: "Roko", image: "", mobile: "", notes: "", email: ""),
                    Contact(name: "Saba Dolaberidze", image: "", mobile: "", notes: "", email: ""),
                    Contact(name: "Tako Abramidze", image: "", mobile: "", notes: "", email: ""),
                    Contact(name: "Vika Pilpani", image: "", mobile: "", notes: "", email: ""),
                    Contact(name: "Zaza Mgaloblishvili", image: "", mobile: "", notes: "", email: ""),
                    Contact(name: "Giorgi Saakashvili", image: "", mobile: "", notes: "", email: "")
                    
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getSectionTitle()
        configTableView()
        setupNavigationBar()
    }
    
    
    @objc func buttonFunc () {
        print("button function")
    }
    
    func setupNavigationBar(){
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "+", style: .plain, target: self, action: #selector(buttonFunc))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Group",  style: .plain, target: self, action: #selector(buttonFunc))
        self.title = "Contacts"
    }
    
    func configTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.sectionHeaderHeight = UITableView.automaticDimension
        //        self.tableView.estimatedRowHeight = 44
        
        self.tableView.registerNib(class: MyProfileTableViewCell.self)
        self.tableView.registerNib(class: ContactsTableViewCell.self)
        self.tableView.register(UINib(nibName: "ContactsHeaderFooterView", bundle: nil),
                                forHeaderFooterViewReuseIdentifier: "ContactsHeaderFooterView")
//        self.tableView.separatorColor = .clear
    }
    
    func getSectionTitle() -> [String]{
        for contact in contacts {
            contactNames.append(contact.name)
        }
        sectionTitle = Array(Set(contactNames.compactMap({String($0.prefix(1))})))
        sectionTitle.sort()
        sectionTitle.forEach({contactDict[$0] = [String]()})
        contactNames.forEach({contactDict[String($0.prefix(1))]?.append($0)})
        return sectionTitle
    }
    
}

extension HomeViewController: UITableViewDelegate {
    
}

extension HomeViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sectionTitle.count + 1
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return self.contactDict[sectionTitle[section - 1]]?.count ?? 0
        
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "ContactsHeaderFooterView") as? ContactsHeaderFooterView
        if section == 0 {
            return headerView
        } else {
            headerView?.headerTitleLabel.text = self.sectionTitle[section - 1]
            return headerView
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 && indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MyProfileTableViewCell", for: indexPath)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ContactsTableViewCell", for: indexPath)
            cell.textLabel?.text = self.contactDict[sectionTitle[indexPath.section - 1]]?[indexPath.row]
            return cell
        }
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        sectionTitle
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "DetailViewController", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "DetailViewController")
        navigationController?.pushViewController(viewController, animated: true)
    }
}

