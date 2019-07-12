//
//  ButtonTableViewCell.swift
//  0610
//
//  Created by Chris on 2019/6/17.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit

class ButtonTableViewCell: UITableViewCell {

    var buttonTitle: String? {
        didSet {
            if let buttonTitle = buttonTitle {
                button.setTitle(buttonTitle, for: .normal)
            }
        }
    }

    var buttonColorHex: String? {
        didSet {
            if let buttonColorHex = buttonColorHex, let color = UIColor(hexString: buttonColorHex) {
                button.backgroundColor = color
            }
        }
    }

    var buttonTextColorHex: String? {
        didSet {
            if let buttonTextColorHex = buttonTextColorHex, let color = UIColor(hexString: buttonTextColorHex) {
                button.setTitleColor(color, for: .normal)
            }
        }
    }

    var webStr: String?

    @IBOutlet weak var button: UIButton!

    @IBAction func clickButton(_ sender: UIButton) {
        if let webStr = webStr, let url = URL(string: webStr) {
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
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
