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
        user.email = "test15@test.com"
        user.password = "123456"
        user.name = "test"
        
        UserUtils.createUserProfile(user)
    }
    
    func setupNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "userCreationSuccess:", name: notifUserCreationSuccess, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "userCreationFail:", name: notifUserCreationFail, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func userCreationSuccess(notification: NSNotification) {
        println(notification)
    }
    
    func userCreationFail(notification: NSNotification) {
        println(notification)
    }
}

