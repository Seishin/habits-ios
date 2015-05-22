//
//  NotificationsUtils.swift
//  Habits
//
//  Created by Atanas Dimitrov on 5/22/15.
//  Copyright (c) 2015 Seishin. All rights reserved.
//

class NotificationsUtils {
    
    static func sendNotificaiton(name: String, object: AnyObject?) {
        NSNotificationCenter.defaultCenter().postNotificationName(name, object: object)
    }
    
    static func sendFailureNotification(reason: String) {
        NSNotificationCenter.defaultCenter().postNotificationName(notifFailure, object: ["reason": reason])
    }
}