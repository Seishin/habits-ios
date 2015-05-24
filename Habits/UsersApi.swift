//
//  UsersApi.swift
//  Habits
//
//  Created by Atanas Dimitrov on 5/22/15.
//  Copyright (c) 2015 Seishin. All rights reserved.
//

// Notifications names
let notifUserCreationSuccess = "notif_user_creation_success"
let notifUserLoginSuccess = "notif_user_login_success"

class UsersApi {
    
    private static let instance: UsersApi = UsersApi()
    private let userBaseUrl = baseUrl + "/users"
    
    init() {}
    
    static func getInstance() -> UsersApi {
        return instance
    }
    
    func createUser(user: User) {
        JSONHTTPClient.postJSONFromURLWithString(userBaseUrl, bodyData: user.toJSONData()) { (response: AnyObject!, error: JSONModelError!) -> Void in
            
            if (error != nil) {
                NotificationsUtils.sendFailureNotification("Cannot create user's profile!")
            } else {
                UserUtils.storeUserProfile(self.getUserObjectFromResponse(response!), onComplete: { () -> Void in
                    NotificationsUtils.sendNotificaiton(notifUserCreationSuccess, object: UserUtils.getUserProfile())
                })
            }
        }
    }
    
    func loginUser(user: User) {
        let url: String = userBaseUrl + "/login"
        
        JSONHTTPClient.postJSONFromURLWithString(url, bodyData: user.toJSONData()) { (response: AnyObject!, error: JSONModelError!) -> Void in
            
            if (error != nil) {
                NotificationsUtils.sendFailureNotification("Cannot login the user!")
            } else {
                UserUtils.storeUserProfile(self.getUserObjectFromResponse(response!), onComplete: { () ->
                    Void in
                    NotificationsUtils.sendNotificaiton(notifUserLoginSuccess, object: UserUtils.getUserProfile())
                })
            }
        }
    }
    
    func getUserById(id: String, onComplete: (user: User?) -> Void) {
        let url: String = userBaseUrl + "/" + id
        
        JSONHTTPClient.getJSONFromURLWithString(url, completion: { (response: AnyObject!, error: JSONModelError!) -> Void in
            
            if (error != nil) {
                onComplete(user: nil)
            } else {
                onComplete(user: self.getUserObjectFromResponse(response))
            }
        })
    }
    
    private func getUserObjectFromResponse(response: AnyObject) -> User {
        var data: NSDictionary = NSDictionary(dictionary: response as! [NSObject : AnyObject])
        
        var user: User = User()
        user.id = data["_id"] as! String
        user.name = data["name"] as! String
        user.email = data["email"] as! String
        user.token = data["token"] as! String
        user.stats = data["stats"] as? String
        
        return user
    }
}
