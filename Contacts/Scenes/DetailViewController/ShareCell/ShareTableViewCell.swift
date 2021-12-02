//
//  ShareTableViewCell.swift
//  Contacts
//
//  Created by Ana Mepisashvili on 02.12.21.
//

import UIKit

class ShareTableViewCell: UITableViewCell, UITableViewDelegate, UITableViewDataSource {

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: contentView.bounds)
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "TableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.layer.cornerRadius = 10
        return tableView
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.addSubview(tableView)
        
        let margins = UIEdgeInsets(top: 5, left: 8, bottom: 25, right: 8)
        tableView.frame = tableView.frame.inset(by: margins)
        contentView.frame = contentView.frame.inset(by: margins)
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath)
        return cell
    }
    
}
