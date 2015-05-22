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
        user.email = "test"
        user.password = "test"
//        user.name = "test"
        
//        ApiClient.getUsersApi().createUser(user)
        ApiClient.getUsersApi().loginUser(user)
        
//        println(UserUtils.getUserProfile())
        
//        ApiClient.getUsersApi().getUserById("555ed5f92fe0280300a9d1b0", onComplete: { (user) -> Void in
//            println(user)
//        })
        
//        ApiClient.getUserStatsApi().getStats(UserUtils.getUserProfile()!)
        
    }
    
    func setupNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onUserCreationSuccess:", name: notifUserCreationSuccess, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onUserLoginSuccess:", name: notifUserLoginSuccess, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onUserStatsGetSuccess:", name: notifUserStatsGetSuccess, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onDailyTasksListGetSuccess:", name: notifDailyTasksListGetSuccess, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onDailyTaskGetSuccess:", name: notifDailyTaskGetSuccess, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onDailyTaskChangeStateSuccess:", name: notifDailyTaskChangeStateSuccess, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onDailyTaskRemove:", name: notifDailyTaskRemove, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onDailyTaskCreateSuccess:", name: notifDailyTaskCreateSuccess, object: nil)
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
//        ApiClient.getDailyTasksApi().getDailyTask(UserUtils.getUserProfile()!, taskId: "55009019b094e5030015115f", date: "2015-05-22")
//        ApiClient.getDailyTasksApi().getDailyTasks(UserUtils.getUserProfile()!, date: "2015-05-22")
        
        
        let task: DailyTask = DailyTask()
//        task.id = "555f9c39fdde3d0300446f69"
        task.text = "Test2"
        
        ApiClient.getDailyTasksApi().createDailyTask(UserUtils.getUserProfile()!, dailyTask: task)
        
//        ApiClient.getDailyTasksApi().getDailyTasks(UserUtils.getUserProfile()!, date: "2015-05-22")
//        ApiClient.getDailyTasksApi().checkDailyTask(UserUtils.getUserProfile()!, dailyTask: task, date: "2015-05-22")
//        ApiClient.getDailyTasksApi().removeDailyTask(UserUtils.getUserProfile()!, dailyTask: task)
    }
    
    func onUserStatsGetSuccess(notification: NSNotification) {
        println((notification.object as! UserStats).maxLvlExp)
    }
    
    func onDailyTasksListGetSuccess(notification: NSNotification) {
//        println(notification)
        let tasks: DailyTasksList = notification.object as! DailyTasksList
        
        for var i = 0; i < tasks.dailyTasks.count; i++ {
            println(tasks.dailyTasks.objectAtIndex(i))
        }
    }
    
    func onDailyTaskCreateSuccess(notification: NSNotification) {
        println(notification.object)
    }
    
    func onDailyTaskGetSuccess(notification: NSNotification) {
        println(notification.object)
    }
    
    func onDailyTaskChangeStateSuccess(notification: NSNotification) {
        println(notification.object)
    }
    
    func onDailyTaskRemove(notification: NSNotification) {
        println(notification)
    }
    
    func onFailure(notification: NSNotification) {
        println(notification)
    }
}

