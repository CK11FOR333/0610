//
//  MainTabBarController.swift
//  0610
//
//  Created by Chris on 2019/6/10.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit
import SwiftyJSON

enum MyViewControllerType: String {
    case viewController0 = "工作咖啡廳"
    case viewController1 = "地圖"
    case viewController2 = "我的"
    case viewController3 = "自定義介面0" // Brand.json
    case viewController4 = "自定義介面1" // Coffee.json
    case viewController5 = "自定義介面2" // Decentralization.json
    case viewController6 = "自定義介面3" // Eshopping.json
    case viewController7 = "自定義介面4" // Fairness.json
}

class MainTabBarController: UITabBarController {

    var myVCs: [Activity] = []

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        getJSON()
    }

    func getJSON() {
        requestManager.getActivitys(success: { [weak self] (json) in
            log.info(json)

            let list = json["list"].arrayValue
            for activity in list {
                let myVC = Activity(vc: activity["vc"].stringValue, img: activity["img"].stringValue, name: activity["name"].stringValue)
                self?.myVCs.append(myVC)
            }
            
            self?.setupTabBar(with: json)
        })
    }

    func setupTabBar(with json: JSON) {
        var vcs = [UIViewController]()

        // If the number of view controllers is greater than the number displayable by a tab bar, a "More" navigation controller will automatically be shown.

        var count = myVCs.count
        if count > 5 {
            count = 5
        }

        for index in 0 ..< count {
            let myVC = myVCs[index]

            switch myVC.vc {
            case "ViewController0":
                let homeVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController

                homeVC.navigationItem.title = MyViewControllerType.viewController0.rawValue

                let homeNav = UINavigationController.init(rootViewController: homeVC)
                if #available(iOS 11.0, *) {
                    homeNav.navigationBar.prefersLargeTitles = true
                } else {
                    // Fallback on earlier versions
                }
                homeNav.tabBarItem.image = UIImage(named: "tabbar_icon_shop_default")
                homeNav.tabBarItem.title = "咖啡廳"

                vcs.append(homeNav)

            case "ViewController1":
                let collectiveVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
                collectiveVC.navigationItem.title = MyViewControllerType.viewController1.rawValue
                let collectiveNav = UINavigationController.init(rootViewController: collectiveVC)
                collectiveNav.tabBarItem.image = UIImage(named: "tabbar_icon_map_default")
                collectiveNav.tabBarItem.title = MyViewControllerType.viewController1.rawValue

                vcs.append(collectiveNav)

            case "ViewController2":
                let settingVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SettingViewController") as! SettingsViewController
                settingVC.navigationItem.title = MyViewControllerType.viewController2.rawValue
                let settingNav = UINavigationController.init(rootViewController: settingVC)
                settingNav.tabBarItem.image = UIImage(named: "tabbar_icon_mine_default")
                settingNav.tabBarItem.title = MyViewControllerType.viewController2.rawValue

                vcs.append(settingNav)

            default:
                let mixVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MIxViewController") as! MIxViewController

                switch myVC.vc {
                case "ViewController3":
                    mixVC.vcType = .viewController3
                case "ViewController4":
                    mixVC.vcType = .viewController4
                case "ViewController5":
                    mixVC.vcType = .viewController5
                case "ViewController6":
                    mixVC.vcType = .viewController6
                case "ViewController7":
                    mixVC.vcType = .viewController7
                default:
                    assertionFailure("wrong viewController name")
                    break
                }

                mixVC.navigationItem.title = myVC.name
                let mixNav = UINavigationController.init(rootViewController: mixVC)
                mixNav.tabBarItem.image = UIImage(named: myVC.img)
                mixNav.tabBarItem.title = myVC.name

                vcs.append(mixNav)
            }
        }

        self.setViewControllers(vcs, animated: false)
    }

}
