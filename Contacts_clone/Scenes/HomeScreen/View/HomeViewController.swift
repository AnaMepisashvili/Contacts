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
    
    lazy var viewModel: HomeVCViewModel = {HomeVCViewModel(tableView: tableView, navController: navigationController!, navItem: navigationItem)}()
    
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.loadContacts()
        viewModel.setupNavigationBar()
        viewModel.configTableView()
        viewModel.setHeaders { [weak self] in
            self?.viewModel.setDict()
        }
       
    }
}
