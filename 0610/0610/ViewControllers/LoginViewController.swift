//
//  LoginViewController.swift
//  0610
//
//  Created by Chris on 2019/7/30.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import GoogleSignIn
import SVProgressHUD

class LoginViewController: UIViewController {


    @IBOutlet weak var googleButton: GIDSignInButton!

    @IBOutlet weak var logoutButton: UIButton!

    @IBOutlet weak var emailTextField: UITextField!

    @IBOutlet weak var passwordTextField: UITextField!





    @IBAction func clickGoogleButton(_ sender: UIButton) {
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signIn()
    }

    @IBAction func clickLogOutButton(_ sender: UIButton) {
        GIDSignIn.sharedInstance().signOut()
        GIDSignIn.sharedInstance().disconnect()
    }


    @IBAction func clickSignUpButton(_ sender: UIButton) {
        if emailTextField.text == "" {
            let alertController = UIAlertController(title: "Error", message: "Please enter your email and password", preferredStyle: .alert)

            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)

            present(alertController, animated: true, completion: nil)

        } else {
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { [weak self] authResult, error in
                guard let strongSelf = self else { return }
                // ...
                if error == nil {
                    log.info("You have successfully signed up")
                    //Goes to the Setup page which lets the user take a photo for their profile picture and also chose a username

                    let alertController = UIAlertController(title: "Sign Up Succedd", message: error?.localizedDescription, preferredStyle: .alert)

                    let defaultAction = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                        strongSelf.navigationController?.popViewController()
                    })
                    alertController.addAction(defaultAction)

                    strongSelf.present(alertController, animated: true, completion: nil)                    

                } else {
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)

                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)

                    strongSelf.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }

    @IBAction func clickSignInButton(_ sender: UIButton) {
        if emailTextField.text == "" {
            let alertController = UIAlertController(title: "Error", message: "Please enter your email and password", preferredStyle: .alert)

            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)

            present(alertController, animated: true, completion: nil)

        } else {
            Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { [weak self] authResult, error in
                guard let strongSelf = self else { return }
                // ...
                if error == nil {
                    if let user = authResult?.user {

                        log.info("Sign In", context: nil)

                        // The user's ID, unique to the Firebase project.
                        // Do NOT use this value to authenticate with your backend server,
                        // if you have one. Use getTokenWithCompletion:completion: instead.
                        let uid = user.uid
                        let email = user.email
                        let photoURL = user.photoURL
                        // ...

                        let alertController = UIAlertController(title: "Sign In Succedd", message: error?.localizedDescription, preferredStyle: .alert)

                        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                            strongSelf.navigationController?.popViewController()
                        })
                        alertController.addAction(defaultAction)

                        strongSelf.present(alertController, animated: true, completion: nil)

                    }
                } else {
                    log.debug("Sing In Error \(error!.localizedDescription)")
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)

                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)

                    strongSelf.present(alertController, animated: true, completion: nil)
                }
            }
        }

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
