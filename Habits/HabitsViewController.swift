//
//  ViewController.swift
//  Habits
//
//  Created by Atanas Dimitrov on 5/8/15.
//  Copyright (c) 2015 Seishin. All rights reserved.
//

import UIKit

class HabitsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNotifications()
        
        var user: User = User()
        user.email = "test10"
        user.password = "test"
        user.name = "test"
        
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
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onHabitCreateSuccess:", name: notifHabitCreateSuccess, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onHabitIncrementSuccess:", name: notifHabitIncrementSuccess, object: nil)
        
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
//        let habit: Habit = Habit()
//        habit.text = "Bla"
        
//        ApiClient.getHabitsApi().createHabit(UserUtils.getUserProfile()!, habit: habit)
//        ApiClient.getHabitsApi().getHabit(UserUtils.getUserProfile()!, id: "5560661bc9a83d0300133185")
//        ApiClient.getHabitsApi().getHabitsList(UserUtils.getUserProfile()!)
//        ApiClient.getHabitsApi().removeHabit(UserUtils.getUserProfile()!, id: "5560661bc9a83d0300133185")
//        ApiClient.getHabitsApi().incrementHabit(UserUtils.getUserProfile()!, id: "556075b761515c900ff528fd")
        
        var reward: Reward = Reward()
        reward.text = "test"
        reward.gold = 30
        
//        ApiClient.getRewardsApi().createReward(UserUtils.getUserProfile()!, reward: reward)
//        ApiClient.getRewardsApi().getAllRewards(UserUtils.getUserProfile()!)
//        ApiClient.getRewardsApi().getReward(UserUtils.getUserProfile()!, id: "55634aea01d8248123ad9f0c")
        ApiClient.getRewardsApi().buyReward(UserUtils.getUserProfile()!, id: "55634aea01d8248123ad9f0c")
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
        println(notification)
    }
    
    func onDailyTaskGetSuccess(notification: NSNotification) {
        println(notification.object)
    }
    
    func onDailyTaskChangeStateSuccess(notification: NSNotification) {
        println(notification)
    }
    
    func onDailyTaskRemove(notification: NSNotification) {
        println(notification)
    }
    
    
    func onHabitCreateSuccess(notification: NSNotification) {
        println(notification.object)
    }
    
    func onHabitIncrementSuccess(notification: NSNotification) {
        println(notification.object)
    }
    
    
    func onFailure(notification: NSNotification) {
        println(notification)
    }
}

