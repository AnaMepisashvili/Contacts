//
//  DetailViewController.swift
//  Contacts
//
//  Created by Ana Mepisashvili on 01.12.21.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var headerViewHeight: NSLayoutConstraint!
    @IBOutlet weak var headerViewTop: NSLayoutConstraint!
    @IBOutlet weak var containerViewTop: NSLayoutConstraint!
    
    var maxScrollAmount: CGFloat {
        let expandedHeight = headerViewHeight.constant
        let collapsedHeight = containerViewTop.constant
        return expandedHeight - collapsedHeight
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        
        imgView.layer.masksToBounds = true
        imgView.layer.cornerRadius = 38
        
        if let scrollView = containerView.subviews.first as? UIScrollView {
            scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
        
        if var scrollViewContained = children.first as? ScrollViewContained {
            scrollViewContained.scrollDelegate = self
        }
    }
    
    @objc func buttonFunc() {
        print("button function")
    }
    
    func setupNavigationBar(){
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(buttonFunc))
    }
}

// MARK: - ScrollViewContaining Delegate
extension DetailViewController: ScrollViewContainingDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let newTopConstraintConstant = -(scrollView.contentOffset.y + scrollView.contentInset.top)
        headerViewTop.constant = min(0, max(-maxScrollAmount, newTopConstraintConstant))
        let isAtTop = headerViewTop.constant == -maxScrollAmount
        scrollViewScrolled(scrollView, didScrollToTop: isAtTop)
        
    }
    
    func scrollViewScrolled(_ scrollView: UIScrollView, didScrollToTop isAtTop:Bool) {
        headerView.backgroundColor = isAtTop ? UIColor.systemGray5 : UIColor.systemGray5
    }
}

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

//        let nib1 = UINib(nibName: "PhoneTableViewCell", bundle: nil)
//        let nib2 = UINib(nibName: "NotesTableViewCell", bundle: nil)
//        let nib3 = UINib(nibName: "ShareTableViewCell", bundle: nil)
//        let nib4 = UINib(nibName: "EmergencyTableViewCell", bundle: nil)
//        let nib5 = UINib(nibName: "LocationTableViewCell", bundle: nil)
//        let nib6 = UINib(nibName: "BlockTableViewCell", bundle: nil)
        
//        tableView.register(nib1, forCellReuseIdentifier: "PhoneTableViewCell")
        tableView.register(PhoneTableViewCell.self, forCellReuseIdentifier: "PhoneTableViewCell")
        tableView.register(NotesTableViewCell.self, forCellReuseIdentifier: "NotesTableViewCell")
        tableView.register(EmergencyTableViewCell.self, forCellReuseIdentifier: "EmergencyTableViewCell")
        tableView.register(LocationTableViewCell.self, forCellReuseIdentifier: "LocationTableViewCell")
        tableView.register(BlockTableViewCell.self, forCellReuseIdentifier: "BlockTableViewCell")
        tableView.register(ShareTableViewCell.self, forCellReuseIdentifier: "ShareTableViewCell")

//        tableView.register(nib2, forCellReuseIdentifier: "NotesTableViewCell")
//        tableView.register(nib3, forCellReuseIdentifier: "ShareTableViewCell")
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
            return UIScreen.main.bounds.height / 12
        case 1 :
            return UIScreen.main.bounds.height / 7
        case 2 :
            return UIScreen.main.bounds.height / 4.5
        case 3 :
            return UIScreen.main.bounds.height / 15
        case 4 :
            return UIScreen.main.bounds.height / 15
        case 5 :
            return UIScreen.main.bounds.height / 15
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


// MARK: - Protocols
protocol ScrollViewContainingDelegate: NSObject {
    func scrollViewDidScroll(_ scrollView: UIScrollView)
}
protocol ScrollViewContained {
    var scrollDelegate: ScrollViewContainingDelegate? { get set }
}
