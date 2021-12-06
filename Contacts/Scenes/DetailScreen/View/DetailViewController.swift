//
//  DetailViewController.swift
//  Contacts
//
//  Created by Ana Mepisashvili on 01.12.21.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var mailBtn:  UIButton!
    @IBOutlet weak var videobtn: UIButton!
    @IBOutlet weak var callBtn: UIButton!
    @IBOutlet weak var messageBtn: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var headerViewHeight: NSLayoutConstraint!
    @IBOutlet weak var headerViewTop: NSLayoutConstraint!
    @IBOutlet weak var imageViewTop: NSLayoutConstraint!
    @IBOutlet weak var containerViewTop: NSLayoutConstraint!
    
    private var lastContentOffset: CGFloat = 0
    
    //MARK: - Variables
    
    var name: String?
    var avatarImage: String?
    var contact: Contact?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupView()
        
        self.automaticallyAdjustsScrollViewInsets = false
        imgView.layer.cornerRadius = imgView.bounds.width/2
        mailBtn.layer.cornerRadius = 10
        videobtn.layer.cornerRadius = 10
        callBtn.layer.cornerRadius = 10
        messageBtn.layer.cornerRadius = 10

        if var scrollViewContained = children.first as? ScrollViewContained {
            scrollViewContained.scrollDelegate = self
        }
    }
    
    //MARK: - Functions
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TableView" {
            if let destination = segue.destination as? TableViewController {
                destination.contact = contact
            }
        }
    }
    
    private func setupView(){
        nameLabel.text = name
        imgView.image = UIImage(named: contact!.image)
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
//        func scrollViewDidScroll(_ scrollView: UIScrollView) {
//
//            let newTopConstraintConstant = -(scrollView.contentOffset.y + scrollView.contentInset.top)
//            headerViewTop.constant = min(0, max(-maxScrollAmount, newTopConstraintConstant))
//            let isAtTop = headerViewTop.constant == -maxScrollAmount
//            scrollViewScrolled(scrollView, didScrollToTop: isAtTop)
//
//        }
//
//        func scrollViewScrolled(_ scrollView: UIScrollView, didScrollToTop isAtTop:Bool) {
//            headerView.backgroundColor = isAtTop ? UIColor.systemGray5 : UIColor.systemGray5
//        }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (self.lastContentOffset < scrollView.contentOffset.y) {
            if scrollView.contentOffset.y < 100 && scrollView.contentOffset.y > 0 {
                headerViewHeight.constant = 225 - 0.6 * scrollView.contentOffset.y
                imageViewTop.constant = 10 - 0.44 * scrollView.contentOffset.y
                imgView.transform = CGAffineTransform(scaleX: 1.0 - 0.005 * scrollView.contentOffset.y, y: 1.0 - 0.005 * scrollView.contentOffset.y)
                nameLabel.transform = CGAffineTransform(scaleX: 1.0 - 0.005 * scrollView.contentOffset.y, y: 1.0 - 0.005 * scrollView.contentOffset.y)
            }
        }
    }
}

// MARK: - Protocols
protocol ScrollViewContainingDelegate: NSObject {
    func scrollViewDidScroll(_ scrollView: UIScrollView)
}
protocol ScrollViewContained {
    var scrollDelegate: ScrollViewContainingDelegate? { get set }
}
