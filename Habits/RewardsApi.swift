//
//  RewardsApi.swift
//  Habits
//
//  Created by Atanas Dimitrov on 5/24/15.
//  Copyright (c) 2015 Seishin. All rights reserved.
//

// Notifications names
let notifRewardCreateSuccess = "notif_reward_create_success"
let notifRewardGetSuccess = "notif_reward_get_success"
let notifRewardGetAllSuccess = "notif_reward_get_all_success"
let notifRewardRemoveSuccess = "notif_reward_remove_success"
let notifRewardBuySuccess = "notif_reward_buy_succes"

class RewardsApi {
    
    private static let instance: RewardsApi = RewardsApi()
    private let rewardsBaseUrl: String = baseUrl + "/rewards/"
    
    static func getInstance() -> RewardsApi {
        return instance
    }
    
    init() {}
    
    func createReward(user: User, reward: Reward) {
        let url: String = rewardsBaseUrl + "?userId=" + String(user.id)
        
        JSONHTTPClient.requestHeaders().setValue(user.token, forKey: "Authorization")
        JSONHTTPClient.postJSONFromURLWithString(url, bodyData: reward.toJSONData()) { (response: AnyObject!, error: JSONModelError!) -> Void in
            
            if (error != nil) {
                NotificationsUtils.sendFailureNotification("Cannot create this reward.")
            } else {
                let reward: Reward = self.getRewardObjectFromResponse(response)!
                NotificationsUtils.sendNotificaiton(notifRewardCreateSuccess, object: reward)
            }
        }
    }
    
    func getReward(user: User, id: String) {
        let url: String = rewardsBaseUrl + id + "/?userId=" + String(user.id)
        
        JSONHTTPClient.requestHeaders().setValue(user.token, forKey: "Authorization")
        JSONHTTPClient.getJSONFromURLWithString(url, completion: { (response: AnyObject!, error: JSONModelError!) -> Void in
            
            if (error != nil) {
                NotificationsUtils.sendFailureNotification("Cannot get this reward.")
            } else {
                let reward: Reward = self.getRewardObjectFromResponse(response)!
                NotificationsUtils.sendNotificaiton(notifRewardGetSuccess, object: reward)
            }
        })
    }
    
    func getAllRewards(user: User) {
        let url: String = rewardsBaseUrl + "all/?userId=" + String(user.id)
        
        JSONHTTPClient.requestHeaders().setValue(user.token, forKey: "Authorization")
        JSONHTTPClient.getJSONFromURLWithString(url, completion: { (response: AnyObject!, error: JSONModelError!) -> Void in
            
            if (error != nil) {
                NotificationsUtils.sendFailureNotification("Cannot get all reward.")
            } else {
                let rewardsList: RewardsList = self.getRewardsListObjectFromResponse(response)!
                NotificationsUtils.sendNotificaiton(notifRewardGetAllSuccess, object: rewardsList)
            }
        })
    }
    
    func removeReward(user: User, id: String) {
        let url: String = rewardsBaseUrl + id + "?userId=" + String(user.id)
        
        JSONHTTPClient.JSONFromURLWithString(url, method: "DELETE", params: nil, orBodyData: nil, headers: ["Authorization" : user.token]) { (response: AnyObject!, error: JSONModelError!) -> Void in
            
            if (error != nil) {
                NotificationsUtils.sendFailureNotification("Cannot delete this reward.")
            } else {
                let id: String = response.valueForKey("id") as! String
                NotificationsUtils.sendNotificaiton(notifRewardRemoveSuccess, object:["id": id])
            }
        }
    }
    
    func buyReward(user: User, id: String) {
        let url: String = rewardsBaseUrl + "buy/" + id + "/?userId=" + String(user.id)
        
        JSONHTTPClient.requestHeaders().setValue(user.token, forKey: "Authorization")
        JSONHTTPClient.postJSONFromURLWithString(url, bodyData: nil) { (response: AnyObject!, error: JSONModelError!) -> Void in
            
            if (error != nil) {
                NotificationsUtils.sendFailureNotification("Cannot buy this reward.")
            } else {
                let reward: Reward = self.getRewardObjectFromResponse(response)!
                NotificationsUtils.sendNotificaiton(notifRewardBuySuccess, object: reward)
            }
        }
    }
    
    private func getRewardObjectFromResponse(response: AnyObject) -> Reward? {
        var data: NSDictionary = NSDictionary(dictionary: response as! [NSObject : AnyObject])
        
        var reward: Reward = Reward()
        reward.id = data.valueForKey("_id") as! String
        reward.userId = data.valueForKey("user") as! String
        reward.text = data.valueForKey("text") as! String
        reward.gold = data.valueForKey("gold") as! Int
        
        return reward
    }
    
    private func getRewardsListObjectFromResponse(response: AnyObject) -> RewardsList? {
        let data: NSDictionary = NSDictionary(dictionary: response as! [NSObject : AnyObject])
        let rewards: NSArray = data.valueForKey("rewards") as! NSArray
        
        var rewardsList: RewardsList = RewardsList()
        
        for item in rewards {
            var reward: Reward = Reward()
            reward.id = data.valueForKey("_id") as! String
            reward.userId = data.valueForKey("user") as! String
            reward.text = data.valueForKey("text") as! String
            reward.gold = data.valueForKey("gold") as! Int
            
            rewardsList.rewardsList.addObject(reward)
        }
        
        return rewardsList
    }
}