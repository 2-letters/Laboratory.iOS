//
//  AppDelegate.swift
//  Laboratory
//
//  Created by Administrator on 5/7/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import UIKit
import Firebase


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
            
        NSSetUncaughtExceptionHandler { exception in
            print(Thread.callStackSymbols)
        }
        
        signal(SIGABRT) { _ in
            print(Thread.callStackSymbols)
        }
        
        signal(SIGILL) { _ in
            print(Thread.callStackSymbols)
        }
        
        signal(SIGSEGV) { _ in
            print(Thread.callStackSymbols)
        }
        
        signal(SIGFPE) { _ in
            print(Thread.callStackSymbols)
        }
        
        signal(SIGBUS) { _ in
            print(Thread.callStackSymbols)
        }
        
        signal(SIGPIPE) { _ in
            print(Thread.callStackSymbols)
        }
        
        
        FirebaseApp.configure()
        
        UILabel.appearance().font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle(rawValue: globalFont))
        
        // change Status Bar color
        if application.responds(to: Selector(("statusBar"))),
        let statusBar = application.value(forKey: "statusBar") as? UIView,
            statusBar.responds(to: #selector(getter: CATextLayer.foregroundColor)) {
            statusBar.setValue(UIColor.white, forKey: "foregroundColor")
        }
        
        // change Navigation Bar Background Color
        UINavigationBar.appearance().barTintColor = Color.lightLavender
        // change Back button title & icon color
        UINavigationBar.appearance().tintColor = UIColor.white
        // To change Navigation Bar Title Color
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
//        UINavigationBar.shadow
        
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

