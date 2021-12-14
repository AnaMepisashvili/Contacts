//
//  ViewController.swift
//  Contacts
//
//  Created by Ana Mepisashvili on 01.12.21.
//

import UIKit
import Contacts

class HomeViewController: UIViewController {
    //MARK: - Outlets

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet private var tableView: UITableView!
    
    //MARK: - Properties
    
    var viewModel: HomeVCViewModelProtocol!
    var manager = ContactsManager.shared
    
    var headers: [String] = []
    var dict: [String: [Contact]] = [:]
    
    override func loadView() {
        super.loadView()
        manager.loadContactsIntoCoreData()
//        manager.coreDataManager.clearContactsInCoreData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
        setupNavigationBar()
        configTableView()
        manager.coreDataManager.getContactsFromCoreData { result in
            switch result {
            case.success(let contacts):
                print(contacts)
            case.failure(let error):
                print(error)
            }
        }
        setHeaders { [weak self] in
            self?.setDict()
        }
    }
    //MARK: - Functions
    
    private func setHeaders(completion: @escaping () -> Void) {
        manager.getHeaders { [weak self] headers in
            self?.headers = headers
            completion()
        }
    }
    
    private func setDict() {
        manager.getDict(headers: headers) { [weak self] dict in
            self?.dict = dict
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    func configTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.sectionHeaderHeight = UITableView.automaticDimension
        self.tableView.registerNib(class: MyProfileTableViewCell.self)
        let nib = UINib(nibName: "ContactsTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "ContactsTableViewCell")
        //        self.tableView.sectionHeaderTopPadding = 0.5
        self.tableView.register(UINib(nibName: "ContactsHeaderFooterView", bundle: nil),
                                forHeaderFooterViewReuseIdentifier: "ContactsHeaderFooterView")
    }
    
    @objc func buttonFunc () {
        print("button function")
    }
    
    func setupViewModel(){
        let viewModel = HomeVCViewModel()
    }
    
    func setupNavigationBar(){
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "+", style: .plain, target: self, action: #selector(buttonFunc))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Group",  style: .plain, target: self, action: #selector(buttonFunc))
        self.title = "Contacts"
    }
}
// MARK: - UITableView Extension

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return headers.count + 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        guard let  dict = dict[headers[section - 1]] else {return 0}
        
        return dict.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "ContactsHeaderFooterView") as? ContactsHeaderFooterView
        if section == 0 {
            return headerView
        } else {
            headerView?.headerTitleLabel.text = headers[section - 1]
            return headerView
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            if section == 0 {
                return 0
            }
            return 25
        }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 && indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MyProfileTableViewCell", for: indexPath)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ContactsTableViewCell", for: indexPath) as! ContactsTableViewCell
            cell.contact = dict[headers[indexPath.section - 1]]![indexPath.row]
            return cell
        }
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "#"]
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "DetailViewController", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        let contact = dict[headers[indexPath.section - 1]]![indexPath.row]
        viewController.name = (contact.firstName ?? "") + " " + (contact.lastName ?? "")
        viewController.contact = contact
        navigationController?.pushViewController(viewController, animated: true)
    }
}
