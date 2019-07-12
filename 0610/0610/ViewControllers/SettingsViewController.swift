//
//  SettingViewController.swift
//  0610
//
//  Created by Chris on 2019/6/11.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit
import MessageUI

class SettingsViewController: UIViewController {

    var vcType: MyViewControllerType!

    let selectedBackgroundView = UIView()

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTableView()

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        applyTheme()
    }

    func setupNavigationBar() {
        navigationController?.navigationBar.barStyle = UserDefaults.standard.bool(forKey: "kIsDarkTheme") ? .default : .black
        
        navigationController?.navigationBar.backgroundColor = Theme.current.navigationBar
        navigationController?.navigationBar.barTintColor = Theme.current.navigationBar
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = Theme.current.tint
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Theme.current.tint]
    }

    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self

        selectedBackgroundView.backgroundColor = Theme.current.tableViewCellSelectedBackground
    }

    fileprivate func applyTheme() {
        view.backgroundColor = Theme.current.tableViewBackground
        tableView.backgroundColor = Theme.current.tableViewBackground
        tableView.reloadData()

        self.setupNavigationBar()

        self.tabBarController?.tabBar.barTintColor = Theme.current.tabBar
        self.tabBarController?.tabBar.tintColor = Theme.current.tint
        if #available(iOS 10.0, *) {
            self.tabBarController?.tabBar.unselectedItemTintColor = Theme.current.tabBarUnSelected
        } else {
            // Fallback on earlier versions
        }
    }

    func presentContactUsPage() {
        guard MFMailComposeViewController.canSendMail() else { return }

        let mailController = MFMailComposeViewController()

        mailController.navigationBar.tintColor = UIColor.white
        mailController.mailComposeDelegate = self

        mailController.setSubject("宜蘭工作咖啡館 \(appVersionString)")

        let toRecipients = ["kay_hsiao@zonvan.com.tw"]
        mailController.setToRecipients(toRecipients)

        present(mailController, animated: true, completion: nil)
    }

}

extension SettingsViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.accessoryType = .disclosureIndicator
            cell.textLabel?.text = "我的收藏"
            cell.textLabel?.textColor = Theme.current.tableViewCellLightText
            cell.backgroundColor = Theme.current.tableViewCellBackgorund
            cell.selectedBackgroundView = selectedBackgroundView

            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SwitchTableViewCell", for: indexPath) as! SwitchTableViewCell
            
            cell.titleLabel.text = "夜間模式"
            cell.delegate = self

            if UserDefaults.standard.bool(forKey: "kIsDarkTheme") {
                cell.switch.setOn(true, animated: false)
            } else {
                cell.switch.setOn(false, animated: false)
            }

            cell.backgroundColor = Theme.current.tableViewCellBackgorund
//            cell.selectedBackgroundView = selectedBackgroundView
            cell.selectionStyle = .none
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.accessoryType = .disclosureIndicator
            cell.textLabel?.text = "回報問題"
            cell.textLabel?.textColor = Theme.current.tableViewCellLightText
            cell.backgroundColor = Theme.current.tableViewCellBackgorund
            cell.selectedBackgroundView = selectedBackgroundView
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.accessoryType = .disclosureIndicator
            cell.textLabel?.text = "隱私權政策"
            cell.textLabel?.textColor = Theme.current.tableViewCellLightText
            cell.backgroundColor = Theme.current.tableViewCellBackgorund
            cell.selectedBackgroundView = selectedBackgroundView
            return cell
        default:
            assertionFailure("no match cell with type")
        }

        let cell = UITableViewCell()
        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return nil
    }

    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "version \(appVersionString)"
    }

}

extension SettingsViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        switch indexPath.row {
        case 0:
            let myCollectedVC = UIStoryboard.main?.instantiateViewController(withIdentifier: "MyCollectedViewController") as! MyCollectedViewController
            navigationController?.pushViewController(myCollectedVC)
        case 2:
            presentContactUsPage()
        case 3:
            if let url = URL(string: "https://www.privacypolicies.com/privacy/view/8e2cca5e0327d9b039adce7bb9031f8c") {
                if #available(iOS 10, *) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(url)
                }
            }
        default:
            break
        }
    }

}

extension SettingsViewController: SwitchTableViewCellDelegate {

    func switchTheme() {
        applyTheme()
    }

}

// MARK: - MF Mail compose view controller delegate

extension SettingsViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}
