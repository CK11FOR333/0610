//
//  AppDelegate.swift
//  0610
//
//  Created by Chris on 2019/6/10.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit
import Fabric
import Crashlytics
import SwiftyBeaver
import Firebase
import FirebaseAuth
import GoogleSignIn

let log = SwiftyBeaver.self

let appDelegate = UIApplication.shared.delegate as! AppDelegate

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        setupFabric()
        setupSwiftyBeaver()
        setupFirebase()
        setupGoogleSignIn()
        applyTheme()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

}

extension AppDelegate {

    @available(iOS 9.0, *)
    func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
            return GIDSignIn.sharedInstance().handle(url,
                                                     sourceApplication:options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
                                                     annotation: [:])
    }

}

extension AppDelegate {

    func setupFabric() {
        Fabric.with([Crashlytics.self])
        // TODO: Move this to where you establish a user session
        self.logUser()
    }

    func logUser() {
        // TODO: Use the current user's information
        // You can call any combination of these three methods
//        Crashlytics.sharedInstance().setUserEmail("user@fabric.io")
//        Crashlytics.sharedInstance().setUserIdentifier("12345")
//        Crashlytics.sharedInstance().setUserName("Test User")
    }

    func setupSwiftyBeaver() {
        // add log destinations. at least one is needed!
        let console = ConsoleDestination()  // log to Xcode Console
        let file = FileDestination()  // log to default swiftybeaver.log file
        let cloud = SBPlatformDestination(appID: "MmnRZ7", appSecret: "noarUzP7agwkSuqiesbcy0auonjynMOt", encryptionKey: "hjgKwmrp8cywcdulqoyH72jniqc8elfm") // to cloud

        // use custom format and set console output to short time, log level & message
        console.format = "$DHH:mm:ss.SSS$d $C$L$c $N.$F:$l - $M"
        // or use this for JSON output: console.format = "$J"

        // add the destinations to SwiftyBeaver
        log.addDestination(console)
        log.addDestination(file)
        log.addDestination(cloud)
    }

    func setupFirebase() {
        FirebaseApp.configure()
    }

    func applyTheme() {
        if UserDefaults.standard.object(forKey: "kIsDarkTheme") == nil {
            UserDefaults.standard.set(false, forKey: "kIsDarkTheme")
            Theme.current = LightTheme()
        } else {
            Theme.current = UserDefaults.standard.bool(forKey: "kIsDarkTheme") ? DarkTheme() : LightTheme()
        }
    }

}

// MARK: - Google Sign In

extension AppDelegate: GIDSignInDelegate {

    func setupGoogleSignIn() {
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
    }

    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        // ...
        if let error = error {
            // ...
            log.error("Google Sign In Error: \(error.localizedDescription)")
            return
        }

        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)
        // ...
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if let error = error {
                //
                log.error("Auth Sign In Error: \(error.localizedDescription)")
                return
            }
            // User is signed in
            // ...
            log.info("Signing In Succeed")
        }
    }

    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // ...
        // ...
        if let error = error {
            // ...
            log.error("Signing Out Error: \(error.localizedDescription)")
            return
        }

        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            log.info("Signing Out Succeed")
        } catch let signOutError as NSError {
            log.debug("Error signing out: \(signOutError.localizedDescription)")
        }

    }

}

extension AppDelegate {

    func presentAlertView(_ title: String?, message: String?, completion: (() -> Void)? = nil) {
        let visibleViewController = window?.visibleViewController
        visibleViewController?.presentAlertView(title, message: message, completion: completion)
    }

}
