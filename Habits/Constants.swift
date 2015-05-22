//
//  Constants.swift
//  Habits
//
//  Created by Atanas Dimitrov on 5/20/15.
//  Copyright (c) 2015 Seishin. All rights reserved.
//

// Urls
let baseUrl = "http://habits-app.herokuapp.com"
let userUrl = baseUrl + "/users"
let loginUserUrl = userUrl + "/login"
let userStatsUrl = baseUrl + "/stats"
let dailyTasksUrl = baseUrl + "/daily-tasks/"
let getAllDailyTasksUrl = dailyTasksUrl + "all/"

// UserDefaults Keys
let kUserId: String = "userId"
let kUserName: String = "name"
let kUserEmail: String = "email"
let kUserToken: String = "token"
let kUserStats: String = "stats"

// Notification Keys
let notifUserCreationSuccess = "notif_user_creation_success"
let notifUserLoginSuccess = "notif_user_login_success"
let notifFailure = "notif_failure"

let notifUserStatsGetSuccess = "notif_user_stats_get_success"
let notifDailyTasksListGetSuccess = "notif_daily_tasks_get_success"
let notifDailyTaskGetSuccess = "notif_daily_task_get_success"
let notifDailyTaskChangeStateSuccess = "notif_daily_task_change_state_success"
let notifDailyTaskCreateSuccess = "notif_daily_task_create_success"
let notifDailyTaskRemove = "notif_daily_task_remove"
