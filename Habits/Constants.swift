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

// UserDefaults Keys
let kUserId: String = "userId"
let kUserName: String = "name"
let kUserEmail: String = "email"
let kUserToken: String = "token"

// Notification Keys
let notifUserCreationSuccess = "notif_user_creation_success"
let notifUserLoginSuccess = "notif_user_login_success"
let notifFailure = "notif_failure"
