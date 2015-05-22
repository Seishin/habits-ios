//
//  UserUtils.swift
//  Habits
//
//  Created by Atanas Dimitrov on 5/21/15.
//  Copyright (c) 2015 Seishin. All rights reserved.
//

struct UserUtils {
    
    private static var userDefaults: NSUserDefaults = NSUserDefaults()
    
    static func storeUserProfile(user: User, onComplete: () -> Void) {
        self.userDefaults.setValue(user.id, forKey: kUserId)
        self.userDefaults.setValue(user.email, forKey: kUserEmail)
        self.userDefaults.setValue(user.name, forKey: kUserName)
        self.userDefaults.setValue(user.token, forKey: kUserToken)
        
        onComplete()
    }
    
    static func getUserProfile() -> User? {
        if checkIfUserIsLoggedIn() {
            var user: User = User()
            user.id = userDefaults.valueForKey(kUserId) as! String
            user.name = userDefaults.valueForKey(kUserName) as! String
            user.email = userDefaults.valueForKey(kUserEmail) as! String
            user.token = userDefaults.valueForKey(kUserToken) as! String
            
            return user;
        }
        
        return nil
    }
    
    static func logout() {
        self.userDefaults.removeObjectForKey(kUserId)
        self.userDefaults.removeObjectForKey(kUserEmail)
        self.userDefaults.removeObjectForKey(kUserName)
        self.userDefaults.removeObjectForKey(kUserToken)
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