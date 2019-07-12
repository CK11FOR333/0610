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

let log = SwiftyBeaver.self

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        setupFabric()
        setupSwiftyBeaver()
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

    func applyTheme() {
        if UserDefaults.standard.object(forKey: "kIsDarkTheme") == nil {
            UserDefaults.standard.set(false, forKey: "kIsDarkTheme")
            Theme.current = LightTheme()
        } else {
            Theme.current = UserDefaults.standard.bool(forKey: "kIsDarkTheme") ? DarkTheme() : LightTheme()
        }
    }

}

