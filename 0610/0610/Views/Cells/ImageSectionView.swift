//
//  ImageSectionView.swift
//  0610
//
//  Created by Chris on 2019/6/11.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit
//import Kingfisher
import SwifterSwift
import Alamofire
import AlamofireImage

protocol ImageSectionViewDelegate: class {
    func sectionView(_ sectionView: ImageSectionView, _ didPressTag: Int, _ isExpand: Bool)
}

class ImageSectionView: UITableViewHeaderFooterView {

    weak var delegate: ImageSectionViewDelegate?

    var buttonTag: Int!
    var isExpand: Bool! // cell 的狀態(展開/縮合)

    var imageStr: String? {
        didSet {
            if let imageStr = imageStr, let url = URL(string: imageStr) {
                //
                //                let imageView = UIImageView(frame: frame)
                //                let placeholderImage = UIImage(named: "placeholder")!

                let filter = ScaledToSizeFilter(size: sectionImageView.frame.size)

                //                let filter = AspectScaledToFillSizeWithRoundedCornersFilter(
                //                    size: cellImageView.frame.size,
                //                    radius: 20.0
                //                )

                sectionImageView.af_setImage(
                    withURL: url,
                    placeholderImage: nil,
                    filter: filter,
                    imageTransition: .crossDissolve(0.2)
                )

//                let processor = DownsamplingImageProcessor(size: sectionImageView.frame.size)
//
//                sectionImageView.kf.indicatorType = .activity
//                sectionImageView.kf.setImage(
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
                sectionImageView.image = nil
            }
        }
    }

    @IBOutlet weak var sectionImageView: UIImageView!

    @IBAction func clickImageButton(_ sender: UIButton) {
        self.delegate?.sectionView(self, self.buttonTag, self.isExpand)
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    override func prepareForReuse() {
        super.prepareForReuse()
        
    }

}

