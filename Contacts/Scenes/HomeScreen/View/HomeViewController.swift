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
    
    var viewModel: HomeVCViewModelProtocol!
    var dataSource: DataSource!    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
        setupNavigationBar()
    }
    
    
    @objc func buttonFunc () {
        print("button function")
    }
    
    func setupViewModel(){
        let viewModel = HomeVCViewModel()
        dataSource = DataSource(with: tableView, with: viewModel, with: navigationController!)
    }
    
    func setupNavigationBar(){
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "+", style: .plain, target: self, action: #selector(buttonFunc))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Group",  style: .plain, target: self, action: #selector(buttonFunc))
        self.title = "Contacts"
    }

}

extension HomeViewController: UITableViewDelegate {
    
}
