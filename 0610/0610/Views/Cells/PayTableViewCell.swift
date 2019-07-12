//
//  PayTableViewCell.swift
//  0610
//
//  Created by Chris on 2019/6/17.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit
import Kingfisher

class PayTableViewCell: UITableViewCell {

    var cellModels: [Content]? {
        didSet {
            if let contents = cellModels {
                leftViewLabel.text = contents[0].text
                leftViewLabel.textColor = UIColor(hexString: contents[0].textColor!)
                leftView.backgroundColor = UIColor(hexString: contents[0].textBackgroundColor!)
                leftViewImageView.kf.setImage(with: URL(string: contents[0].textImage!))

                middleViewLabel.text = contents[1].text
                middleViewLabel.textColor = UIColor(hexString: contents[1].textColor!)
                middleView.backgroundColor = UIColor(hexString: contents[1].textBackgroundColor!)
                middleViewImageView.kf.setImage(with: URL(string: contents[1].textImage!))

                rightViewLabel.text = contents[2].text
                rightViewLabel.textColor = UIColor(hexString: contents[2].textColor!)
                rightView.backgroundColor = UIColor(hexString: contents[2].textBackgroundColor!)
                rightViewImageView.kf.setImage(with: URL(string: contents[2].textImage!))
            }
        }
    }
//
//    var aliPayWebURLStr: String?
//
//    var weChatWebURLStr: String?
//
//    var fastPayWebURLStr: String?

    @IBOutlet weak var leftView: UIView!
    @IBOutlet weak var middleView: UIView!
    @IBOutlet weak var rightView: UIView!

    @IBOutlet weak var leftViewButton: UIButton!
    @IBOutlet weak var middleViewButton: UIButton!
    @IBOutlet weak var rightViewButton: UIButton!

    @IBOutlet weak var leftViewImageView: UIImageView!
    @IBOutlet weak var middleViewImageView: UIImageView!
    @IBOutlet weak var rightViewImageView: UIImageView!

    @IBOutlet weak var leftViewLabel: UILabel!
    @IBOutlet weak var middleViewLabel: UILabel!
    @IBOutlet weak var rightViewLabel: UILabel!

    @IBAction func clickLeftViewButton(_ sender: UIButton) {
        if let contents = cellModels, let aliPayWebURLStr = contents[0].textWeb, let url = URL(string: aliPayWebURLStr) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                // Fallback on earlier versions
                UIApplication.shared.openURL(url)
            }
        }
    }

    @IBAction func clickMiddleViewButton(_ sender: UIButton) {
        if let contents = cellModels, let weChatWebURLStr = contents[1].textWeb, let url = URL(string: weChatWebURLStr) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                // Fallback on earlier versions
                UIApplication.shared.openURL(url)
            }
        }
    }

    @IBAction func clickRightViewButton(_ sender: UIButton) {
        if let contents = cellModels, let fastPayWebURLStr = contents[2].textWeb, let url = URL(string: fastPayWebURLStr) {
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
        leftView.cornerRadius = 5
        middleView.cornerRadius = 5
        rightView.cornerRadius = 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
