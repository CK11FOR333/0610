//
//  BannerTableViewCell.swift
//  0610
//
//  Created by Chris on 2019/6/14.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit
import MarqueeLabel
//import JXMarqueeView

class BannerTableViewCell: UITableViewCell {

    var marqueelStr: String? {
        didSet {
            if let marqueelStr = marqueelStr {
//                marqueeLabel.text = marqueelStr

//                UIView.animate(withDuration: 12.0, delay: 1, options: ([.curveLinear, .repeat]), animations: {() -> Void in
//
//                    self.marqueeLabel.center = CGPoint(x: 0 - self.marqueeLabel.bounds.size.width / 2, y: self.marqueeLabel.center.y)
//
//                }, completion:  { _ in })

//                self.setNeedsLayout()
            }
        }
    }

//    var marqueeView = JXMarqueeView()
//    var marqueeLabel = UILabel()

    @IBOutlet weak var bannerView: LLCycleScrollView!

    @IBOutlet weak var marqueelTitleLabel: UILabel!

    @IBOutlet weak var marqueeBackgroundView: UIView!

    @IBOutlet weak var marqueeLabel: MarqueeLabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        // 新增图片显示控制
        bannerView.imageViewContentMode = .scaleToFill
        bannerView.customPageControlStyle = .snake
        bannerView.pageControlPosition = .center

        // 是否对url进行特殊字符处理
        self.bannerView.isAddingPercentEncodingForURLString = true

        // 網站公告
        marqueelTitleLabel.text = ""

        // 跑馬燈連續滾動

        //文字
//
//        marqueeLabel.text = "abcdefghijklmnopqrstuvwxyz"
//        marqueeLabel.textColor = .white
//        marqueeLabel.font = UIFont.systemFont(ofSize: 30, weight: .medium)
//
//
//        marqueeLabel.sizeThatFits(marqueeBackgroundView.size)
//
//        marqueeView.contentView = marqueeLabel
//        marqueeView.contentMargin = 50
//        marqueeView.marqueeType = .left
//
//        marqueeView.translatesAutoresizingMaskIntoConstraints = false
//
//        marqueeBackgroundView.addSubview(marqueeView)
//
//        let leadingCons = NSLayoutConstraint(item: marqueeView, attribute: .leading, relatedBy: .equal, toItem: marqueeBackgroundView, attribute: .leading, multiplier: 1, constant: 0)
//        let trailingCons = NSLayoutConstraint(item: marqueeView, attribute: .trailing, relatedBy: .equal, toItem: marqueeBackgroundView, attribute: .trailing, multiplier: 1, constant: 0)
//        let topCons = NSLayoutConstraint(item: marqueeView, attribute: .top, relatedBy: .equal, toItem: marqueeBackgroundView, attribute: .top, multiplier: 1, constant: 0)
//        let bottomCons = NSLayoutConstraint(item: marqueeView, attribute: .bottom, relatedBy: .equal, toItem: marqueeBackgroundView, attribute: .top, multiplier: 1, constant: 0)
//
//        NSLayoutConstraint.activate([leadingCons, trailingCons, topCons, bottomCons])

//        marqueelLabel.text = ""
//        marqueelLabel.labelize = false
//        marqueelLabel.type = .continuous
//        marqueelLabel.animationCurve = .easeInOut
//        marqueelLabel.fadeLength = 10.0
//        marqueelLabel.leadingBuffer = 14.0
//
//        marqueelLabel.restartLabel()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    override func prepareForReuse() {
        super.prepareForReuse()
//        marqueelLabel.labelize = false
//        marqueelLabel.restartLabel()
    }
    
}
