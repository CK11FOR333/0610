//
//  TypeTwoTableViewCell.swift
//  0610
//
//  Created by Chris on 2019/6/18.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit

class TypeTwoTableViewCell: UITableViewCell {

    var cellBackgroundColor: UIColor?

    var cellModels: [Content]? {
        didSet {
            self.tableView.reloadData()
        }
    }

    @IBOutlet weak var tableView: UITableView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupTableView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setupTableView() {
        tableView.dataSource = self

        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        tableView.backgroundColor = cellBackgroundColor

        let routeTableViewCell: UINib = UINib(nibName: "RouteTableViewCell", bundle: nil)
        tableView.register(routeTableViewCell, forCellReuseIdentifier: "RouteTableViewCell")
    }
    
}

extension TypeTwoTableViewCell: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let cellModels = cellModels, cellModels.count > 0 {
            return cellModels.count
        } else {
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RouteTableViewCell", for: indexPath) as! RouteTableViewCell

        cell.contentView.backgroundColor = cellBackgroundColor
        cell.backgroundColor = cellBackgroundColor

        cell.titleButton.setTitle(cellModels![indexPath.row].text, for: .normal)
        cell.titleButton.setTitleColor(UIColor(hexString: cellModels![indexPath.row].textColor!), for: .normal)
        cell.titleButton.backgroundColor = UIColor(hexString: cellModels![indexPath.row].textBackgroundColor!)

        cell.enterButton.setTitle(cellModels![indexPath.row].info, for: .normal)
        cell.enterButton.setTitleColor(UIColor(hexString: cellModels![indexPath.row].infoColor!), for: .normal)
        cell.enterButton.backgroundColor = UIColor(hexString: cellModels![indexPath.row].infoBackgroundColor!)

        cell.webURL = cellModels![indexPath.row].infoWeb

        return cell
    }

}
