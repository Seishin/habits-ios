//
//  RewardsViewController.swift
//  Habits
//
//  Created by Atanas Dimitrov on 5/28/15.
//  Copyright (c) 2015 Seishin. All rights reserved.
//

class RewardsViewController: UIViewController, YALTabBarInteracting {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNotifications()
        initUI()
    }
    
    func setupNotifications() {
    
    }
    
    func initUI() {
    
    }
    
    func extraLeftItemDidPressed() {
        
    }
    
    func extraRightItemDidPressed() {
        self.tabBarController?.performSegueWithIdentifier("profileSegue", sender: self)
    }
}
