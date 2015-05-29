//
//  DailyTasks.swift
//  Habits
//
//  Created by Atanas Dimitrov on 5/28/15.
//  Copyright (c) 2015 Seishin. All rights reserved.
//

class DailyTasksViewController: UIViewController, YALTabBarViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNotifications()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if UserUtils.checkIfUserIsLoggedIn() {
            ApiClient.getDailyTasksApi().getDailyTasks(UserUtils.getUserProfile()!)
        }
    }
    
    func setupNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onDailyTasksListGetSuccess:", name: notifDailyTasksListGetSuccess, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onDailyTaskGetSuccess:", name: notifDailyTaskGetSuccess, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onDailyTaskCreateSuccess:", name: notifDailyTaskCreateSuccess, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onDailyTaskChangeSuccess:", name: notifDailyTaskChangeStateSuccess, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onDailyTaskRemoveSuccess:", name: notifDailyTaskRemove, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onFailure:", name: notifFailure, object: nil)
    }
    
    func onDailyTasksListGetSuccess(notification: NSNotification) {
        println(notification.object)
    }
    
    func onDailyTaskGetSuccess(notification: NSNotification) {
    
    }
    
    func onDailyTaskCreateSuccess(notification: NSNotification) {
    
    }
    
    func onDailyTaskChangeSuccess(notification: NSNotification) {
    
    }
    
    func onDailyTaskRemoveSuccess(notification: NSNotification) {
    
    }
    
    func loadData() {
        ApiClient.getDailyTasksApi().getDailyTasks(UserUtils.getUserProfile()!)
    }
    
    func onFailure(notification: NSNotification) {
        println(notification)
    }
    
    func extraLeftItemDidPressedInTabBarView(tabBarView: YALFoldingTabBar!) {
        println("clicked!")
    }
    
    func extraRightItemDidPressed() {
        self.tabBarController?.performSegueWithIdentifier("profileSegue", sender: self)
    }
}
