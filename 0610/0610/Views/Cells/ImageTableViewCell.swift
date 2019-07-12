//
//  ImageTableViewCell.swift
//  0610
//
//  Created by Chris on 2019/6/11.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit
//import Kingfisher
import Alamofire
import AlamofireImage

protocol ImageTableViewCellDelegate: class {
    func imageTableViewCell(_ cell: ImageTableViewCell, didPressIndexPath indexPath: IndexPath, _ isExpand: Bool)
}

class ImageTableViewCell: UITableViewCell {

    weak var delegate: ImageTableViewCellDelegate?

//    var buttonTag: Int!
    var isExpand: Bool! // cell 的狀態(展開/縮合)

    var indexPath: IndexPath!

    var imageStr: String? {
        didSet {
            if let imageStr = imageStr, let url = URL(string: imageStr) {
//
//                let imageView = UIImageView(frame: frame)
//                let placeholderImage = UIImage(named: "placeholder")!

                let filter = ScaledToSizeFilter(size: cellImageView.frame.size)

//                let filter = AspectScaledToFillSizeWithRoundedCornersFilter(
//                    size: cellImageView.frame.size,
//                    radius: 20.0
//                )

                cellImageView.af_setImage(
                    withURL: url,
                    placeholderImage: nil,
                    filter: filter,
                    imageTransition: .crossDissolve(0.2)
                )



//                imageView.kf.setImage(with: url, placeholder: UIImage(named: "image-placeholder-icon"), options: nil, progressBlock: nil, completionHandler: nil)



//                let processor = DownsamplingImageProcessor(size: cellImageView.frame.size)
//
//                cellImageView.kf.indicatorType = .activity
//                cellImageView.kf.setImage(
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
                cellImageView.image = nil
            }
        }
    }


    @IBOutlet weak var cellImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func clickImageButton(_ sender: UIButton) {
        delegate?.imageTableViewCell(self, didPressIndexPath: indexPath, isExpand)
    }

}
