//
//  RouteTableViewCell.swift
//  0610
//
//  Created by Chris on 2019/6/17.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit

class RouteTableViewCell: UITableViewCell {

    var webURL: String?

    @IBOutlet weak var titleButton: UIButton!

    @IBOutlet weak var enterButton: UIButton!

    @IBAction func clickEnterButton(_ sender: UIButton) {
        if let webURL = webURL, let url = URL(string: webURL) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                // Fallback on earlier versions
                UIApplication.shared.openURL(url)
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        titleButton.layer.borderWidth = 1
        titleButton.layer.borderColor = UIColor.darkGray.cgColor
        titleButton.layer.cornerRadius = 5
        titleButton.layer.masksToBounds = true

        enterButton.cornerRadius = 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
