//
//  MyCollectedViewController.swift
//  0610
//
//  Created by Chris on 2019/7/3.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit

class MyCollectedViewController: UIViewController {

    let theme = Theme.current

    var cafes: [Cafe] = []
    var searchResult: [Cafe] = []

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTableView()
        getJSON()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        applyTheme()
    }

    func setupNavigationBar() {
        // NavigationBar
        self.title = "我的收藏"

        navigationController?.navigationBar.barStyle = UserDefaults.standard.bool(forKey: "kIsDarkTheme") ? .default : .black

        navigationController?.navigationBar.backgroundColor = theme.navigationBar
        navigationController?.navigationBar.barTintColor = theme.navigationBar
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = theme.tint
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Theme.current.tint]
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: Theme.current.tint]
        } else {
            // Fallback on earlier versions
        }
    }

    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none

        tableView.register(nibWithCellClass: CafeTableViewCell.self)
    }

    @objc func getJSON() {
        cafes = realmManager.getCafes()
        tableView.reloadData()


//        requestManager.getYilanCafe { [weak self] (cafes) in
//            guard let strongSelf = self else { return }
//
//            var myCafes: [Cafe] = []
//
//            for cafe in cafes {
//                let isCollected = UserDefaults.standard.bool(forKey: cafe.id)
//                if isCollected {
//                    myCafes.append(cafe)
//                }
//            }
//
//            strongSelf.cafes = myCafes
//            strongSelf.tableView.reloadData()
//        }
    }

    fileprivate func applyTheme() {
        view.backgroundColor = Theme.current.tableViewBackground
        tableView.backgroundColor = Theme.current.tableViewBackground
        tableView.reloadData()

        setupNavigationBar()
    }

}

extension MyCollectedViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cafes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CafeTableViewCell", for: indexPath) as! CafeTableViewCell
        cell.selectionStyle = .none

//        cell.delegate = self

        cell.indexPath = indexPath

        let cafe = cafes[indexPath.row]
        cell.cafe = cafe

        cell.applyTheme()

        return cell
    }
}

extension MyCollectedViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cafe = cafes[indexPath.row]
        if let url = URL(string: cafe.url) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                // Fallback on earlier versions
                UIApplication.shared.openURL(url)
            }
        }
    }

}
//
//extension MyCollectedViewController: CafeTableViewCellDelegate {
//
//    func didClickCollectButton(_ sender: UIButton, at indexPath: IndexPath) {
//        var cafe: Cafe
//
//        cafe = cafes[indexPath.row]
//
//        var isCollected = UserDefaults.standard.bool(forKey: cafe.id)
//        if isCollected {
//            UserDefaults.standard.set(false, forKey: cafe.id)
//            isCollected = false
//        } else {
//            UserDefaults.standard.set(true, forKey: cafe.id)
//            isCollected = true
//        }
//        UserDefaults.standard.synchronize()
////        tableView.reloadRows(at: [indexPath], with: .automatic)
//        sender.isSelected = isCollected
//    }
//
//}
