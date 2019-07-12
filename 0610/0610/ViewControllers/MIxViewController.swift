//
//  MIxViewController.swift
//  0610
//
//  Created by Chris on 2019/6/10.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit
import SwiftyJSON
//import Kingfisher
import SwifterSwift
import MarqueeLabel
import AVFoundation
import Alamofire
import AlamofireImage

class MIxViewController: UIViewController {

    var vcType: MyViewControllerType!

    var cellModels: [ActivityCellContent] = []

    var isExpendDataList: [Bool] = []

    var backgroundColorHex: String?

    var navBackgroundColorHex: String?

//    var cellPaddingColorHex: String?

    var navImageStr: String? {
        didSet {
            let navImageView = UIImageView(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 300, height: 44)))

            //            self.navigationItem.titleView = navImageView

            log.debug("navImageView.frame.size \(navImageView.frame.size)")
            log.debug("self.navigationItem.titleView.frame.size \(String(describing: self.navigationItem.titleView?.frame.size))")

            if let navImageStr = navImageStr, let url = URL(string: navImageStr) {

                //
                //                let imageView = UIImageView(frame: frame)
                //                let placeholderImage = UIImage(named: "placeholder")!

                let filter = ScaledToSizeFilter(size: navImageView.frame.size)

                //                let filter = AspectScaledToFillSizeWithRoundedCornersFilter(
                //                    size: cellImageView.frame.size,
                //                    radius: 20.0
                //                )

                navImageView.af_setImage(
                    withURL: url,
                    placeholderImage: nil,
                    filter: filter,
                    imageTransition: .crossDissolve(0.2)
                )

//                let processor = DownsamplingImageProcessor(size: navImageView.frame.size)
//
//                navImageView.kf.indicatorType = .activity
//                navImageView.kf.setImage(
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
//                        print("Task done for: \(value.source.url?.absoluteString ?? "")")
//                        self.navigationItem.titleView = navImageView
//                    case .failure(let error):
//                        print("Job failed: \(error.localizedDescription)")
//                    }
//                }
            } else {
//                navImageView.image = UIImage(named: "navPlaceholder")
                navImageView.image = nil
            }
        }
    }

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupTableView()
        getJSON()
    }

    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none

        // type 1
        // now use in storyboard viewController

//        let oneTypeCell: UINib = UINib(nibName: "BannerTableViewCell", bundle: nil)
//        tableView.register(oneTypeCell, forCellReuseIdentifier: "BannerTableViewCell")

        // type 2
        let twoTypeCell: UINib = UINib(nibName: "TypeTwoTableViewCell", bundle: nil)
        tableView.register(twoTypeCell, forCellReuseIdentifier: "TypeTwoTableViewCell")

        // type 3
        let threeTypeCell = UINib(nibName: "PayTableViewCell", bundle: nil)
        tableView.register(threeTypeCell, forCellReuseIdentifier: "PayTableViewCell")

        // type 4
        tableView.register(nibWithCellClass: TypeFourTableViewCell.self)

        // type 5
        tableView.register(nibWithCellClass: ButtonTableViewCell.self)

        // type 6
        // now only use in cell

        // type 6 section
//        let imageSectionView: UINib = UINib(nibName: "ImageSectionView", bundle: nil)
//        tableView.register(imageSectionView, forHeaderFooterViewReuseIdentifier: "ImageSectionView")
        // type 6 row
        let imageTableViewCell: UINib = UINib(nibName: "ImageTableViewCell", bundle: nil)
        tableView.register(imageTableViewCell, forCellReuseIdentifier: "ImageTableViewCell")

        // type 7
        let sevenTableViewCell: UINib = UINib(nibName: "TypeSevenTableViewCell", bundle: nil)
        tableView.register(sevenTableViewCell, forCellReuseIdentifier: "TypeSevenTableViewCell")
    }

    func getJSON() {
        if let vcType = vcType {
            switch vcType {
            case .viewController3:
                requestManager.getＣourse { [weak self] (json) in
                    log.info(json)
                    guard let strongSelf = self else { return }
                    strongSelf.showNavBarImageWith(json: json, vc: strongSelf)
                    strongSelf.setTableViewBackgroundColor(json: json, vc: strongSelf)
                    strongSelf.appCellModelsWith(json: json, vc: strongSelf)
                    self?.tableView.reloadData()
                }
            case .viewController4:
                requestManager.getParty { [weak self] (json) in
                    log.info(json)
                    guard let strongSelf = self else { return }
                    strongSelf.showNavBarImageWith(json: json, vc: strongSelf)
                    strongSelf.setTableViewBackgroundColor(json: json, vc: strongSelf)
                    strongSelf.appCellModelsWith(json: json, vc: strongSelf)
                    self?.tableView.reloadData()
                }
            case .viewController5:
                requestManager.getPopular { [weak self] (json) in
                    log.info(json)
                    guard let strongSelf = self else { return }
                    strongSelf.showNavBarImageWith(json: json, vc: strongSelf)
                    strongSelf.setTableViewBackgroundColor(json: json, vc: strongSelf)
                    strongSelf.appCellModelsWith(json: json, vc: strongSelf)
                    self?.tableView.reloadData()
                }
            case .viewController6:
                requestManager.getHot { [weak self] (json) in
                    log.info(json)
                    guard let strongSelf = self else { return }
                    strongSelf.showNavBarImageWith(json: json, vc: strongSelf)
                    strongSelf.setTableViewBackgroundColor(json: json, vc: strongSelf)
                    strongSelf.appCellModelsWith(json: json, vc: strongSelf)
                    self?.tableView.reloadData()
                }
            case .viewController7:
                requestManager.getMarqueel { [weak self] (json) in
                    log.info(json)
                    guard let strongSelf = self else { return }
                    strongSelf.showNavBarImageWith(json: json, vc: strongSelf)
                    strongSelf.setTableViewBackgroundColor(json: json, vc: strongSelf)
                    strongSelf.appCellModelsWith(json: json, vc: strongSelf)
                    self?.tableView.reloadData()
                }
            default:
                break
            }
        }
    }

    func showNavBarImageWith(json: JSON, vc: UIViewController) {
        guard vc is MIxViewController else { return }

        navBackgroundColorHex = json["navBarColor"].stringValue
        (vc as! MIxViewController).navigationController?.navigationBar.backgroundColor = UIColor(hexString: navBackgroundColorHex!)
        (vc as! MIxViewController).navigationController?.navigationBar.barTintColor = UIColor(hexString: navBackgroundColorHex!)
        (vc as! MIxViewController).navigationController?.navigationBar.isTranslucent = false

        (vc as! MIxViewController).navImageStr = json["navImage"].stringValue
    }

    func setTableViewBackgroundColor(json: JSON, vc: UIViewController) {
        guard vc is MIxViewController else { return }

        backgroundColorHex = json["tableBackgroundColor"].stringValue
        (vc as! MIxViewController).tableView.backgroundColor = UIColor.init(hexString: backgroundColorHex!)
    }

    func appCellModelsWith(json: JSON, vc: UIViewController) {
        guard vc is MIxViewController else { return }

        let list = json["list"].arrayValue

        (vc as! MIxViewController).cellModels = []

        for dic in list {
            let type = dic["type"].intValue

            switch type {
            case 1:
                let oriCons = dic["content"].arrayValue

                var cons: [Content] = []
                for oriCon in oriCons {
                    let content = Content(text: nil, textColor: nil, textBackgroundColor: nil, textImage: oriCon["textImage"].stringValue, textWeb: oriCon["textWeb"].stringValue)
                    cons.append(content)
                }
                if cons.count > 0 {
                    let typeOne = TypeOne(type: type, contents: cons, title: dic["title"].stringValue, titleColor: dic["titleColor"].stringValue, msg: dic["msg"].stringValue, msgColor: dic["msgColor"].stringValue, backgroundColor: dic["backgroundColor"].stringValue)
                    (vc as! MIxViewController).cellModels.append(typeOne)
                }

            case 2:
                let oriCons = dic["content"].arrayValue

                var cons: [Content] = []
                for oriCon in oriCons {
                    let content = Content(text: oriCon["text"].stringValue, textColor: oriCon["textColor"].stringValue, textBackgroundColor: oriCon["textBackgroundColor"].stringValue, textImage: nil, textWeb: nil, info: oriCon["info"].stringValue, infoColor: oriCon["infoColor"].stringValue, infoBackgroundColor: oriCon["infoBackgroundColor"].stringValue, infoImage: nil, infoWeb: oriCon["infoWeb"].stringValue)
                    cons.append(content)
                }
                if cons.count > 0 {
                    let typeTwo = TypeTwo(type: type, contents: cons)
                    (vc as! MIxViewController).cellModels.append(typeTwo)
                }

            case 3:
                let oriCons = dic["content"].arrayValue

                var cons: [Content] = []
                for oriCon in oriCons {
                    let content = Content.init(text: oriCon["text"].stringValue, textColor: oriCon["textColor"].stringValue, textBackgroundColor: oriCon["textBackgroundColor"].stringValue, textImage: oriCon["textImage"].stringValue, textWeb: oriCon["textWeb"].stringValue)
                    cons.append(content)
                }
                let typeThree = TypeThree(type: type, contents: cons)
                (vc as! MIxViewController).cellModels.append(typeThree)

            case 4:
                let cellPaddingColorHex = dic["cellPaddingColor"].stringValue

                let oriCons = dic["content"].arrayValue

                var cons: [Content] = []
                for oriCon in oriCons {
                    let content = Content.init(text: oriCon["text"].stringValue, textColor: oriCon["textColor"].stringValue, textBackgroundColor: oriCon["textBackgroundColor"].stringValue, textImage: oriCon["textImage"].stringValue, textWeb: oriCon["textWeb"].stringValue)
                    cons.append(content)
                }
                if cons.count > 0 {
                    let typeFour = TypeFour(type: type, contents: cons, cellPaddingColor: cellPaddingColorHex)
                    (vc as! MIxViewController).cellModels.append(typeFour)
                }

            case 5:
                let oriCon = dic["content"].dictionaryValue
                let content = Content(text: oriCon["text"]?.stringValue, textColor: oriCon["textColor"]?.stringValue, textBackgroundColor: oriCon["textBackgroundColor"]?.stringValue, textImage: nil, textWeb: oriCon["textWeb"]?.stringValue, info: nil, infoColor: nil, infoBackgroundColor: nil, infoImage: nil, infoWeb: nil)
                let typeFive = TypeFive(type: type, contents: [content])
                (vc as! MIxViewController).cellModels.append(typeFive)

            case 6:
                let oriCon = dic["content"].dictionaryValue
                let content = Content(text: nil, textColor: nil, textBackgroundColor: nil, textImage: oriCon["textImage"]?.stringValue, textWeb: nil, info: nil, infoColor: nil, infoBackgroundColor: nil, infoImage: oriCon["infoImage"]?.stringValue, infoWeb: oriCon["infoWeb"]?.stringValue)
                let type6 = TypeSix(type: type, contents: [content])
                (vc as! MIxViewController).cellModels.append(type6)

            case 7:

                let cellPaddingColorHex = dic["cellPaddingColor"].stringValue

//                (vc as! MIxViewController).cellPaddingColorHex = dic["cellPaddingColor"].stringValue

                let oriCons = dic["content"].arrayValue

                var cons: [Content] = []
                for oriCon in oriCons {
                    let content = Content(text: oriCon["text"].stringValue, textColor: oriCon["textColor"].stringValue, textBackgroundColor: oriCon["textBackgroundColor"].stringValue, textImage: oriCon["textImage"].stringValue, textWeb: oriCon["textWeb"].stringValue, info: nil, infoColor: nil, infoBackgroundColor: nil, infoImage: nil, infoWeb: nil)
                    cons.append(content)
                }
                if cons.count > 0 {
                    let type7 = TypeSeven(type: type, contents: cons, cellPaddingColor: cellPaddingColorHex)
                    (vc as! MIxViewController).cellModels.append(type7)
                }

            default:
                break
            }
        }

        for _ in (vc as! MIxViewController).cellModels {
            (vc as! MIxViewController).isExpendDataList.append(false)
        }
    }

    func calculateImageTableViewCellHeight(with urlStr: String?) -> CGFloat {
        if let urlStr = urlStr, let url = URL(string: urlStr) {
            if let imageHeight = UserDefaults.standard.float(forKey: "ImageH \(urlStr)") {
                return CGFloat(imageHeight)
            } else {
                do {
                    let data = try Data(contentsOf: url)
                    let resultImage = UIImage(data: data)
                    let resultBoundingRect =  CGRect(x: 0, y: 0, width: self.view.frame.width, height: CGFloat(MAXFLOAT))
                    let resultRect  = AVMakeRect(aspectRatio: CGSize(width: (resultImage?.size.width)!, height: (resultImage?.size.height)!), insideRect: resultBoundingRect)
                    let resultImageHeight = resultRect.height
                    log.info("resultImageHeight:\(resultImageHeight)")
                    UserDefaults.standard.set(Float(resultImageHeight), forKey: "ImageH \(urlStr)")
                    return resultImageHeight
                } catch {
                    log.debug(error.localizedDescription)
                    return 200
                }
            }
        } else {
            return 200
        }
    }

}

// MARK: - UITableView DataSource

extension MIxViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return cellModels.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let activity = cellModels[section]
        if activity is TypeSix {
            if isExpendDataList[section] {
                return 2
            } else {
                return 1
            }
        } else {
            return 1
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let content = cellModels[indexPath.section]
        switch content {
        case is TypeOne:
            let cell = tableView.dequeueReusableCell(withIdentifier: "BannerTableViewCell", for: indexPath) as! BannerTableViewCell

            cell.selectionStyle = .none

            cell.marqueeBackgroundView.backgroundColor = UIColor(hexString: (content as! TypeOne).backgroundColor)

            var images: [String] = []
            for content in (content as! TypeOne).contents {
                images.append(content.textImage!)
            }
            cell.bannerView.imagePaths = images

            cell.marqueelTitleLabel.text = (content as! TypeOne).title
            cell.marqueelTitleLabel.textColor = UIColor(hexString: (content as! TypeOne).titleColor)

            // marqueeLabel needs to set in the cellForRowAt func
            cell.marqueeLabel.text = (content as! TypeOne).msg
            cell.marqueeLabel.textColor = UIColor(hexString: (content as! TypeOne).msgColor)
            cell.marqueeLabel.type = .continuous
            cell.marqueeLabel.animationCurve = .easeInOut
            cell.marqueeLabel.fadeLength = 10.0
            cell.marqueeLabel.leadingBuffer = 14.0
//            cell.marqueeLabel.labelize = false
            cell.marqueeLabel.unpauseLabel()

            return cell

        case is TypeTwo:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TypeTwoTableViewCell", for: indexPath) as! TypeTwoTableViewCell
            cell.cellModels = (content as! TypeTwo).contents
            cell.contentView.backgroundColor = UIColor.init(hexString: backgroundColorHex!)
            cell.backgroundColor = UIColor.init(hexString: backgroundColorHex!)
            cell.cellBackgroundColor = UIColor.init(hexString: backgroundColorHex!)
            return cell

        case is TypeThree:
            let cell = tableView.dequeueReusableCell(withIdentifier: "PayTableViewCell", for: indexPath) as! PayTableViewCell
            cell.cellModels = (content as! TypeThree).contents
            cell.contentView.backgroundColor = UIColor.init(hexString: backgroundColorHex!)
            return cell

        case is TypeFour:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TypeFourTableViewCell", for: indexPath) as! TypeFourTableViewCell
            cell.cellModels = (content as! TypeFour).contents
            cell.collectionView.backgroundColor =  UIColor(hexString: (content as! TypeFour).cellPaddingColor)
//            cell.cellBackgroundColor = UIColor(hexString: (content as! TypeFour).contents[0].textBackgroundColor!)
            return cell

        case is TypeFive:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ButtonTableViewCell", for: indexPath) as! ButtonTableViewCell
            cell.buttonTitle = (content as! TypeFive).contents.first?.text
            cell.buttonColorHex = (content as! TypeFive).contents.first?.textBackgroundColor
            cell.webStr = (content as! TypeFive).contents.first?.textWeb
            return cell

        case is TypeSix:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ImageTableViewCell", for: indexPath) as! ImageTableViewCell

            // 已點擊展開
            if isExpendDataList[indexPath.section] {
                if indexPath.row == 0 {
                    cell.imageStr = (content as! TypeSix).contents.first?.textImage
                } else {
                    cell.imageStr = (content as! TypeSix).contents.first?.infoImage
                }
            } else {
                cell.imageStr = (content as! TypeSix).contents.first?.textImage
            }

            cell.isExpand = isExpendDataList[indexPath.section]
//            cell.buttonTag = indexPath.section
            cell.indexPath = indexPath
            cell.delegate = self

            return cell

        case is TypeSeven:
            let cell: TypeSevenTableViewCell = tableView.dequeueReusableCell(withIdentifier: "TypeSevenTableViewCell", for: indexPath) as! TypeSevenTableViewCell
            cell.cellModels = (content as! TypeSeven).contents
            cell.collectionView.backgroundColor = UIColor(hexString: (content as! TypeSeven).cellPaddingColor)
            cell.cellBackgroundColor = UIColor(hexString: (content as! TypeSeven).contents[0].textBackgroundColor!)
            return cell

        default:
            assertionFailure("no match cell with type")
        }

        let cell = UITableViewCell()
        return cell
    }

}

// MARK: - UITableView Delegate

extension MIxViewController: UITableViewDelegate, UIScrollViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let content = cellModels[indexPath.section]
        switch content {
//        case is TypeSix:
////            let cell = tableView.dequeueReusableCell(withIdentifier: "ImageTableViewCell", for: indexPath) as! ImageTableViewCell
//            // 已點擊展開
//            if isExpendDataList[indexPath.section] {
//                if indexPath.row == 0 {
//                    //
//                } else {
//                    if let url = URL(string: (content as! TypeSix).contents[0].infoWeb!) {
//                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
//                    }
//                }
//            }

        case is TypeOne:
            let cell = tableView.cellForRow(at: indexPath) as! BannerTableViewCell

            // De-labelize on selection
            if cell.marqueeLabel.isPaused {
                cell.marqueeLabel.unpauseLabel()
            } else {
                cell.marqueeLabel.pauseLabel()
            }
//            bannerCell.marqueeLabel.labelize = true

        default:
            break
        }
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // Re-labelize all scrolling labels on tableview scroll
        for cell in tableView.visibleCells {
            if cell is BannerTableViewCell {
                let bannerCell = cell as! BannerTableViewCell
//                bannerCell.marqueeLabel.labelize = false
                bannerCell.marqueeLabel.restartLabel()
//                bannerCell.marqueeLabel.unpauseLabel()
            }
        }
    }
//
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        let activity = cellModels[section]
//        switch activity {
//        case is TypeOne:
//            return 0
//        case is TypeTwo:
//            return 0
//        case is TypeThree:
//            return 0
//        case is TypeFour:
//            return 0
//        case is TypeFive:
//            return 0
//        case is TypeSix:
//            return 100
//        case is TypeSeven:
//            return 0
//        default:
//            return 0
//        }
//    }

//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let content = cellModels[section]
//        switch content {
////        case is TypeOne:
////            return nil
////        case is TypeTwo:
////            return nil
////        case is TypeThree:
////            return nil
////        case is TypeFour:
////            return nil
//        case is TypeFive:
//            return nil
//        case is TypeSix:
//            let sectionView: ImageSectionView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "ImageSectionView") as! ImageSectionView
//
//            sectionView.isExpand = self.isExpendDataList[section]
//            sectionView.buttonTag = section
//            sectionView.delegate = self
//
//            sectionView.imageStr = (content as! TypeSix).contents[section].textImage
//
//            return sectionView
//        case is TypeSeven:
//            return nil
//        default:
//            return nil
//        }
//    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let content = cellModels[indexPath.section]
        switch content {
        case is TypeOne:
            return 235

        case is TypeTwo:
            let height: CGFloat = 53.5
            let tall = CGFloat((content as! TypeTwo).contents.count)
            return height * tall

        case is TypeThree:
            return 70

        case is TypeFour:
            let height = 65
            let tall = (content as! TypeFour).contents.count / 3 + (content as! TypeFour).contents.count % 3
            return  CGFloat(height * tall) + 3

        case is TypeFive:
            return 81

        case is TypeSix:
            return indexPath.row == 0 ? 100 : calculateImageTableViewCellHeight(with: (content as! TypeSix).contents.first?.infoImage)

        case is TypeSeven:
            let width = (tableView.frame.size.width - 2) / 3
            let tall = (content as! TypeSeven).contents.count / 3 + (content as! TypeSeven).contents.count % 3
            return  width * CGFloat(tall)

        default:
            return 0
        }
    }

}

//extension MIxViewController: ImageSectionViewDelegate {
//
//    func sectionView(_ sectionView: ImageSectionView, _ didPressTag: Int, _ isExpand: Bool) {
//        self.isExpendDataList[didPressTag] = !isExpand
//        self.tableView.reloadSections(IndexSet(integer: didPressTag), with: .automatic)
//    }
//
//}

extension MIxViewController: ImageTableViewCellDelegate {

    func imageTableViewCell(_ cell: ImageTableViewCell, didPressIndexPath indexPath: IndexPath, _ isExpand: Bool) {
        if indexPath.row == 0 {
            self.isExpendDataList[indexPath.section] = !isExpand
            self.tableView.reloadSections(IndexSet(integer: indexPath.section), with: .automatic)
        } else {
            let content = cellModels[indexPath.section]

            if let infoWeb = (content as! TypeSix).contents[0].infoWeb, let url = URL(string: infoWeb) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                } else {
                    // Fallback on earlier versions
                    UIApplication.shared.openURL(url)
                }
            }
        }
    }

}
