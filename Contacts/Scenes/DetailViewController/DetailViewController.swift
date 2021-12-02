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
        headerView.backgroundColor = isAtTop ? UIColor.green : UIColor.systemIndigo
    }
}

// MARK: - TableView Controller, ScrollViewContained
class TableViewController: UITableViewController, ScrollViewContained {

    weak var scrollDelegate: ScrollViewContainingDelegate?
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollDelegate?.scrollViewDidScroll(scrollView)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.registerNib(class: NotesTableViewCell.self)
        let cell = tableView.deque(class: NotesTableViewCell.self, for: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
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
