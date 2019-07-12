//
//  TypeSevenTableViewCell.swift
//  0610
//
//  Created by Chris on 2019/6/18.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit

class TypeSevenTableViewCell: UITableViewCell {

    var cellBackgroundColor: UIColor?

    var cellModels: [Content]? {
        didSet {
            collectionView.reloadData()
        }
    }

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupCollectionView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self

        collectionView.isScrollEnabled = false

        collectionView.register(nibWithCellClass: ButtonCollectionViewCell.self)
    }
    
}

// MARK: - UICollectionView DataSource

extension TypeSevenTableViewCell: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let cellModels = cellModels, cellModels.count > 0 else {
            return 0
        }
        return cellModels.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ButtonCollectionViewCell = collectionView.dequeueReusableCell(withClass: ButtonCollectionViewCell.self, for: indexPath)
        cell.imageStr = cellModels![indexPath.item].textImage
        cell.titleStr = cellModels![indexPath.item].text
        cell.contentBackgoundView.backgroundColor = cellBackgroundColor
        return cell
    }

}

// MARK: - UICollectionView Delegate

extension TypeSevenTableViewCell: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let urlStr = cellModels![indexPath.item].textWeb!
        if let url = URL(string: urlStr) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                // Fallback on earlier versions
                UIApplication.shared.openURL(url)
            }
        }
    }
    
}

// MARK: - UICollectionView FlowLayout

extension TypeSevenTableViewCell: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.size.width - 6) / 3
        return CGSize(width: width, height: width)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }

}
