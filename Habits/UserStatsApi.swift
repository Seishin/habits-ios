//
//  UserStatsApi.swift
//  Habits
//
//  Created by Atanas Dimitrov on 5/22/15.
//  Copyright (c) 2015 Seishin. All rights reserved.
//

class UserStatsApi {
    
    static let instance: UserStatsApi = UserStatsApi()
    
    init() {}
    
    static func getInstance() -> UserStatsApi {
        return instance
    }
    
    func getStats(user: User) {
        let url: String = userStatsUrl + "/" + String(user.id)
        
        JSONHTTPClient.requestHeaders().setValue(user.token, forKey: "Authorization")
        JSONHTTPClient.getJSONFromURLWithString(url, completion: { (response: AnyObject!, error: JSONModelError!) -> Void in
            
            if (error != nil) {
                NotificationsUtils.sendFailureNotification("Cannot get user's stats!")
            } else {
                NotificationsUtils.sendNotificaiton(notifUserStatsGetSuccess, object: self.getStatsObjectFromResponse(response))
            }
        })
    }
    
    private func getStatsObjectFromResponse(response: AnyObject) -> UserStats {
        var data: NSDictionary = NSDictionary(dictionary: response as! [NSObject : AnyObject])
    
        var stats: UserStats = UserStats()
        stats.hp = data["hp"] as! Int
        stats.exp = data["exp"] as! Int
        stats.gold = data["gold"] as! Int
        stats.lvl = data["lvl"] as! Int
        stats.alive = data["alive"] as! Bool
        stats.minLvlExp = data["minLvlExp"] as! Int
        stats.maxLvlExp = data["maxLvlExp"] as! Int
        
        return stats
    }
}
