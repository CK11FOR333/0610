//
//  HomeViewController.swift
//  0610
//
//  Created by Chris on 2019/6/11.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit
import SwiftyJSON

enum CafeRatingType {
    case wifi
    case seat
    case quiet
    case tasty
    case cheap
    case music
}

class HomeViewController: UIViewController {

    var vcType: MyViewControllerType!

    var cafes: [Cafe] = []
    var searchResult: [Cafe] = []

    var refreshControl: UIRefreshControl!
    var searchController: UISearchController!

    @IBOutlet weak var tableView: UITableView!

//    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTableView()
        getJSON()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        applyTheme()
    }

    fileprivate func applyTheme() {
        view.backgroundColor = Theme.current.tableViewCellBackgorund


        navigationController?.navigationBar.barStyle = UserDefaults.standard.bool(forKey: "kIsDarkTheme") ? .default : .black

        navigationController?.navigationBar.backgroundColor = Theme.current.navigationBar
        navigationController?.navigationBar.barTintColor = Theme.current.navigationBar
        navigationController?.navigationBar.tintColor = Theme.current.tint
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Theme.current.tint]
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: Theme.current.tint]
        } else {
            // Fallback on earlier versions
        }

        searchController.searchBar.tintColor = Theme.current.tint
        searchController.searchBar.barTintColor = Theme.current.accent
        if #available(iOS 11.0, *) {
            navigationItem.searchController = searchController
            navigationItem.hidesSearchBarWhenScrolling = false
        } else {
            // Fallback on earlier versions
            tableView.tableHeaderView = searchController.searchBar
        }

        // Placeholder Customization
//        let textFieldInsideSearchBarLabel = searchController.searchBar.value(forKey: "placeholderLabel") as? UILabel
//        textFieldInsideSearchBarLabel?.textColor = Theme.current.tint


        tableView.backgroundColor = Theme.current.tableViewCellBackgorund

        tableView.reloadData()

        self.tabBarController?.tabBar.barTintColor = Theme.current.tabBar
        self.tabBarController?.tabBar.tintColor = Theme.current.tint
        if #available(iOS 10.0, *) {
            self.tabBarController?.tabBar.unselectedItemTintColor = Theme.current.tabBarUnSelected
        } else {
            // Fallback on earlier versions
        }

        refreshControl.tintColor = Theme.current.tint
    }

    func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "navbar_icon_filter_default"), style: .plain, target: self, action: #selector(showSortActions))

        // SearchController
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.sizeToFit()
        searchController.searchBar.placeholder = "搜尋店家名稱、地址"
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
//        searchController.hidesNavigationBarDuringPresentation = true
        definesPresentationContext = true
    }

    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none

        refreshControl = UIRefreshControl()

        refreshControl.addTarget(self, action: #selector(getJSON), for: .valueChanged)
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            // Fallback on earlier versions
            tableView.addSubview(refreshControl)
        }

        tableView.register(nibWithCellClass: CafeTableViewCell.self)
    }

    @objc func getJSON() {
        requestManager.getYilanCafe { [weak self] (cafes) in
            guard let strongSelf = self else { return }
            strongSelf.cafes = cafes
            if #available(iOS 10.0, *) {
                strongSelf.tableView.refreshControl?.endRefreshing()
            } else {
                // Fallback on earlier versions
                strongSelf.refreshControl.endRefreshing()
            }
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3, execute: {
                strongSelf.tableView.reloadData()
                self?.applyTheme()
            })
        }
    }

    func filterContentForSearchText(searchText: String?) {
        guard let searchText = searchText, !searchText.isEmpty else {
            searchResult.removeAll()
            return
        }

        searchResult = cafes.filter({ (cafe) -> Bool in
            if cafe.name.lowercased().range(of: searchText.lowercased()) != nil {
                return true
            }
            if cafe.address.lowercased().range(of: searchText.lowercased()) != nil {
                return true
            }
            return false
        })
    }

    @objc func showSortActions() {
        let alertController = UIAlertController.init(title: "依種類排序", message: "由大到小", preferredStyle: .actionSheet)
        alertController.addAction(title: "WIFI穩定", style: .default, isEnabled: true) { (action) in
            self.sortCafes(with: .wifi)
        }
        alertController.addAction(title: "通常有位", style: .default, isEnabled: true) { (action) in
            self.sortCafes(with: .seat)
        }
        alertController.addAction(title: "安靜程度", style: .default, isEnabled: true) { (action) in
            self.sortCafes(with: .quiet)
        }
        alertController.addAction(title: "咖啡好喝", style: .default, isEnabled: true) { (action) in
            self.sortCafes(with: .tasty)
        }
        alertController.addAction(title: "價格便宜", style: .default, isEnabled: true) { (action) in
            self.sortCafes(with: .cheap)
        }
        alertController.addAction(title: "裝潢音樂", style: .default, isEnabled: true) { (action) in
            self.sortCafes(with: .music)
        }
        alertController.addAction(title: "取消", style: .cancel, isEnabled: true) { (action) in
            //
        }

        if UIDevice.current.userInterfaceIdiom == .pad {
            alertController.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
            alertController.popoverPresentationController?.permittedArrowDirections = .up
            alertController.popoverPresentationController?.sourceView = self.view
            alertController.popoverPresentationController?.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
        }

        alertController.show()
    }

    func sortCafes(with type: CafeRatingType) {
        switch type {
        case .wifi:
            cafes.sort { (a, b) -> Bool in
                return a.wifi > b.wifi
            }
            tableView.reloadData()
        case .seat:
            cafes.sort { (a, b) -> Bool in
                return a.seat > b.seat
            }
            tableView.reloadData()
        case .quiet:
            cafes.sort { (a, b) -> Bool in
                return a.quiet > b.quiet
            }
            tableView.reloadData()
        case .cheap:
            cafes.sort { (a, b) -> Bool in
                return a.cheap > b.cheap
            }
            tableView.reloadData()
        case .music:
            cafes.sort { (a, b) -> Bool in
                return a.music > b.music
            }
            tableView.reloadData()
        case .tasty:
            cafes.sort { (a, b) -> Bool in
                return a.tasty > b.tasty
            }
            tableView.reloadData()
        }
    }

}

extension HomeViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive {
            return searchResult.count
        } else {
            return cafes.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CafeTableViewCell", for: indexPath) as! CafeTableViewCell
        cell.selectionStyle = .none

//        cell.delegate = self

        cell.indexPath = indexPath

        if searchController.isActive {
            let cafe = searchResult[indexPath.row]
            cell.cafe = cafe
        } else {
            let cafe = cafes[indexPath.row]
            cell.cafe = cafe
        }

        cell.applyTheme()

        return cell
    }

}

extension HomeViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if searchController.isActive {
            let cafe = searchResult[indexPath.row]
            if let url = URL(string: cafe.url) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                } else {
                    // Fallback on earlier versions
                    UIApplication.shared.openURL(url)
                }
            }
        } else {
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

}
//
//extension HomeViewController: CafeTableViewCellDelegate {
//
//    func didClickCollectButton(_ sender: UIButton, at indexPath: IndexPath) {
//        var cafe: Cafe
//        if searchController.isActive {
//            cafe = searchResult[indexPath.row]
//        } else {
//            cafe = cafes[indexPath.row]
//        }
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
////        sender.tintColor = Theme.current.fullStar
//        sender.isSelected = isCollected
//    }
//
//}

extension HomeViewController: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text
        filterContentForSearchText(searchText: searchText)
        tableView.reloadData()
    }

}

extension HomeViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }

//    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        searchBar.resignFirstResponder()
//    }

//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//
//    }

}
