//
//  LoginViewController.swift
//  0610
//
//  Created by Chris on 2019/7/30.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import SVProgressHUD

class LoginViewController: UIViewController {


    @IBOutlet weak var googleButton: GIDSignInButton!

    @IBAction func clickGoogleButton(_ sender: UIButton) {
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signIn()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

// MARK: - GIDSignIn UI Delegate

extension LoginViewController: GIDSignInUIDelegate {

    func sign(inWillDispatch signIn: GIDSignIn!, error: Error!) {
        log.info("")
//        SVProgressHUD.show()
    }

    func sign(_ signIn: GIDSignIn!, present viewController: UIViewController!) {
        log.info("")
        if let visibleViewController = appDelegate.window?.visibleViewController {
            visibleViewController.present(viewController, animated: true, completion: {
                log.info("present")
            })
        }
    }

    func sign(_ signIn: GIDSignIn!, dismiss viewController: UIViewController!) {
        log.info("")
        if let visibleViewController = appDelegate.window?.visibleViewController {
            visibleViewController.dismiss(animated: true, completion: {
                log.info("dismiss")
            })
        }
    }

}
