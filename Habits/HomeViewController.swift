//
//  ViewController.swift
//  Habits
//
//  Created by Atanas Dimitrov on 5/8/15.
//  Copyright (c) 2015 Seishin. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNotifications()
        
        var user: User = User()
        user.email = "test17@test.com"
        user.password = "123456"
        user.name = "test"
        
//        ApiClient.getUsersApi().createUser(user)
//        ApiClient.getUsersApi().loginUser(user)
        
//        println(UserUtils.getUserProfile())
        
//        ApiClient.getUsersApi().getUserById("555ed5f92fe0280300a9d1b0", onComplete: { (user) -> Void in
//            println(user)
//        })
        
        ApiClient.getUserStatsApi().getStats(UserUtils.getUserProfile()!)
        
    }
    
    func setupNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onUserCreationSuccess:", name: notifUserCreationSuccess, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onUserLoginSuccess:", name: notifUserLoginSuccess, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onUserStatsGetSuccess:", name: notifUserStatsGetSuccess, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onFailure:", name: notifFailure, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func onUserCreationSuccess(notification: NSNotification) {
        println(notification)
    }
    
    func onUserLoginSuccess(notification: NSNotification) {
        println(notification)
    }
    
    func onUserStatsGetSuccess(notification: NSNotification) {
        println((notification.object as! UserStats).maxLvlExp)
    }
    
    func onFailure(notification: NSNotification) {
        println(notification)
    }
}

