//
//  UserUtils.swift
//  Habits
//
//  Created by Atanas Dimitrov on 5/21/15.
//  Copyright (c) 2015 Seishin. All rights reserved.
//

struct UserUtils {
    
    private static var userDefaults: NSUserDefaults = NSUserDefaults()
    
    static func createUserProfile(user: User) {
        if user.email != nil {
            ApiClient.createUser(user, onComplete: { (result) -> Void in
                if result != nil {
                    if let user: User = result as User! {
                        self.userDefaults.setValue(user.id, forKey: kUserId)
                        self.userDefaults.setValue(user.email, forKey: kUserEmail)
                        self.userDefaults.setValue(user.name, forKey: kUserName)
                        self.userDefaults.setValue(user.token, forKey: kUserToken)
                        
                        NSNotificationCenter.defaultCenter().postNotificationName(notifUserCreationSuccess, object: self.getUserProfile())
                    } else {
                        self.sendNotification(notifUserCreationFail, object: ["error": "User profile wasn't created"])
                    }
                } else {
                    self.sendNotification(notifUserCreationFail, object: ["error": "User profile wasn't created"])
                }
            })
        } else {
            sendNotification(notifUserCreationFail, object: ["error": "Missing email"])
        }
    }
    
    static func getUserProfile() -> User {
        var user: User = User()
        user.id = userDefaults.valueForKey(kUserId) as! String
        user.name = userDefaults.valueForKey(kUserName) as! String
        user.email = userDefaults.valueForKey(kUserEmail) as! String
        user.token = userDefaults.valueForKey(kUserToken) as! String
        
        return user;
    }
    
    static func checkIfUserIsLoggedIn() -> Bool {
        if userDefaults.valueForKey(kUserId) != nil {
            return true
        }
        
        return false
    }
    
    private static func sendNotification(notificationName: String, object: AnyObject) {
        NSNotificationCenter.defaultCenter().postNotificationName(notificationName, object: object)
    }
}
