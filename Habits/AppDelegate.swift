//
//  AppDelegate.swift
//  Habits
//
//  Created by Atanas Dimitrov on 5/8/15.
//  Copyright (c) 2015 Seishin. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        self.setupTabBar()
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
        if !UserUtils.checkIfUserIsLoggedIn() {
            window?.rootViewController!.performSegueWithIdentifier("loginSegue", sender: self)
        }
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func setupTabBar() {
        var tabBarController: YALFoldingTabBarController = window?.rootViewController as!YALFoldingTabBarController
        
        var habits: YALTabBarItem = YALTabBarItem(itemImage: UIImage(named: "habits"), leftItemImage: UIImage(named: "plus_icon@2x"), rightItemImage: UIImage(named: "profile"))
        var dailyTasks: YALTabBarItem = YALTabBarItem(itemImage: UIImage(named: "daily_tasks"), leftItemImage: UIImage(named: "plus_icon@2x"), rightItemImage: UIImage(named: "profile"))
        var toDos: YALTabBarItem = YALTabBarItem(itemImage: UIImage(named: "todos"), leftItemImage: UIImage(named: "plus_icon@2x"), rightItemImage: UIImage(named: "profile"))
        var rewards: YALTabBarItem = YALTabBarItem(itemImage: UIImage(named: "rewards"), leftItemImage: UIImage(named: "plus_icon@2x"), rightItemImage: UIImage(named: "profile"))
        
        tabBarController.centerButtonImage = UIImage(named: "menu")
        
        tabBarController.leftBarItems = [habits, dailyTasks]
        tabBarController.rightBarItems = [toDos, rewards]
        
        tabBarController.tabBarView.extraTabBarItemHeight = YALExtraTabBarItemsDefaultHeight
        tabBarController.tabBarViewHeight = YALTabBarViewDefaultHeight
        tabBarController.tabBarView.offsetForExtraTabBarItems = YALForExtraTabBarItemsDefaultOffset
        tabBarController.tabBarView.backgroundColor = UIColor.whiteColor()
        tabBarController.tabBarView.tabBarColor = UIColorFromRGB("5C90FF", alpha: 1)
        tabBarController.tabBarView.tabBarViewEdgeInsets = YALTabBarViewHDefaultEdgeInsets
        tabBarController.tabBarView.tabBarItemsEdgeInsets = YALTabBarViewHDefaultEdgeInsets
    }
}

