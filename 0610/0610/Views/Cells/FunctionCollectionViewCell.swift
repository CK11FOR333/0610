//
//  FunctionCollectionViewCell.swift
//  0610
//
//  Created by Chris on 2019/6/17.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit
//import Kingfisher
import Alamofire
import AlamofireImage

class FunctionCollectionViewCell: UICollectionViewCell {

    var imageStr: String? {
        didSet {
            if let imageStr = imageStr, let url = URL(string: imageStr) {


                //                let imageView = UIImageView(frame: frame)
                //                let placeholderImage = UIImage(named: "placeholder")!

//                let filter = ScaledToSizeFilter(size: iconImageView.frame.size)

                //                let filter = AspectScaledToFillSizeWithRoundedCornersFilter(
                //                    size: cellImageView.frame.size,
                //                    radius: 20.0
                //                )

//                iconImageView.af_setImage(
//                    withURL: url,
//                    placeholderImage: nil,
//                    filter: filter,
//                    imageTransition: .crossDissolve(0.2)
//                )


                iconImageView.kf.setImage(with: url, placeholder: UIImage(named: "image-placeholder-icon"), options: nil, progressBlock: nil, completionHandler: nil)



//                let processor = DownsamplingImageProcessor(size: iconImageView.frame.size)
//
//                iconImageView.kf.indicatorType = .activity
//                iconImageView.kf.setImage(
//                    with: url,
//                    placeholder: nil,
//                    options: [
//                        .processor(processor),
//                        .scaleFactor(UIScreen.main.scale),
//                        .transition(.fade(1)),
//                        .cacheOriginalImage
//                    ])
//                {
//                    result in
//                    switch result {
//                    case .success(let value):
//                        log.info("Task done for: \(value.source.url?.absoluteString ?? "")")
//                    case .failure(let error):
//                        log.error("Job failed: \(error.localizedDescription)")
//                    }
//                }
            } else {
                iconImageView.image = UIImage(named: "image-placeholder-icon")
            }
        }
    }

    var titleStr: String? {
        didSet {
            if let titleStr = titleStr {
                titleLabel.text = titleStr
            }
        }
    }

    @IBOutlet weak var iconImageView: UIImageView!

    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var contentBackgoundView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
