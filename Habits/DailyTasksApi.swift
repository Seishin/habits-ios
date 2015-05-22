//
//  DailyTasksApi.swift
//  Habits
//
//  Created by Atanas Dimitrov on 5/22/15.
//  Copyright (c) 2015 Seishin. All rights reserved.
//

class DailyTasksApi {
    
    static let instance: DailyTasksApi = DailyTasksApi()
    
    init() {}
    
    static func getInstance() -> DailyTasksApi {
        return instance
    }
    
    func getDailyTasks(user: User, date: String) {
        JSONHTTPClient.requestHeaders().setValue(user.token, forKey: "Authorization")
        JSONHTTPClient.getJSONFromURLWithString(getAllDailyTasksUrl, params: ["userId": user.id, "date": date]) { (response: AnyObject!, error: JSONModelError!) -> Void in
            
            if (error != nil) {
                NotificationsUtils.sendFailureNotification("Cannot get daily tasks.")
            } else {
                let dailyTasksList: DailyTasksList = self.getDailyTasksListObjectFromResponse(response)!
                NotificationsUtils.sendNotificaiton(notifDailyTasksListGetSuccess, object: dailyTasksList)
            }
        }
    }
    
    func getDailyTask(user: User, taskId: String, date: String) {
        let url: String = dailyTasksUrl + "/" + taskId + "/"
        
        JSONHTTPClient.requestHeaders().setValue(user.token, forKey: "Authorization")
        JSONHTTPClient.getJSONFromURLWithString(url, params: ["userId": user.id, "date": date]) { (response: AnyObject!, error: JSONModelError!) -> Void in
            
            if (error != nil) {
                NotificationsUtils.sendFailureNotification("Cannot get desired daily task.")
            } else {
                let dailyTask: DailyTask = self.getDailyTaskObjectFromResponse(response)!
                NotificationsUtils.sendNotificaiton(notifDailyTaskGetSuccess, object: dailyTask)
            }
        }
    }
    
    func createDailyTask(user: User, dailyTask: DailyTask) {
        let url: String = dailyTasksUrl + "?userId=" + String(user.id)
        
        JSONHTTPClient.requestHeaders().setValue(user.token, forKey: "Authorization")
        JSONHTTPClient.postJSONFromURLWithString(url, bodyData: dailyTask.toJSONData()) { (response: AnyObject!, error: JSONModelError!) -> Void in

            if (error != nil) {
                NotificationsUtils.sendFailureNotification("Cannot get desired daily task.")
            } else {
                let dailyTask: DailyTask = self.getDailyTaskObjectFromResponse(response)!
                NotificationsUtils.sendNotificaiton(notifDailyTaskCreateSuccess, object: dailyTask)
            }
        }
    }
    
    func removeDailyTask(user: User, dailyTask: DailyTask) {
        let url: String = dailyTasksUrl + String(dailyTask.id) + "/?userId=" + String(user.id)
        
        JSONHTTPClient.JSONFromURLWithString(url, method: "DELETE", params: nil, orBodyData: nil, headers: ["Authorization" : user.token]) { (response: AnyObject!, error: JSONModelError!) -> Void in
            
            if (error != nil) {
                NotificationsUtils.sendFailureNotification("Cannot remove the selected daily task.")
            } else {
                let id: String = response.valueForKey("id") as! String
                NotificationsUtils.sendNotificaiton(notifDailyTaskRemove, object:["id": id])
            }
        }
    }
    
    func checkDailyTask(user: User, dailyTask: DailyTask, date: String) {
        let url: String = dailyTasksUrl + String(dailyTask.id) + "/check/?userId=" + String(user.id) + "&date=" + date
        
        JSONHTTPClient.requestHeaders().setValue(user.token, forKey: "Authorization")
        JSONHTTPClient.postJSONFromURLWithString(url, params: nil) { (response: AnyObject!, error: JSONModelError!) -> Void in

            if (error != nil) {
                NotificationsUtils.sendFailureNotification("Cannot check the selected daily task.")
            } else {
                let dailyTask: DailyTask = self.getDailyTaskObjectFromResponse(response)!
                NotificationsUtils.sendNotificaiton(notifDailyTaskChangeStateSuccess, object: dailyTask)
            }
        }
    }
    
    func uncheckDailyTask(user: User, dailyTask: DailyTask, date: String) {
        let url: String = dailyTasksUrl + String(dailyTask.id) + "/uncheck/?userId=" + String(user.id) + "&date=" + date
        
        JSONHTTPClient.requestHeaders().setValue(user.token, forKey: "Authorization")
        JSONHTTPClient.postJSONFromURLWithString(url, params: nil) { (response: AnyObject!, error: JSONModelError!) -> Void in
            
            if (error != nil) {
                NotificationsUtils.sendFailureNotification("Cannot uncheck the selected daily task.")
            } else {
                let dailyTask: DailyTask = self.getDailyTaskObjectFromResponse(response)!
                NotificationsUtils.sendNotificaiton(notifDailyTaskChangeStateSuccess, object: dailyTask)
            }
        }
    }
    
    private func getDailyTaskObjectFromResponse(response: AnyObject) -> DailyTask? {
        var data: NSDictionary = NSDictionary(dictionary: response as! [NSObject : AnyObject])
        
        var task: DailyTask = DailyTask()
        task.id = data.valueForKey("_id") as! String
        task.text = data.valueForKey("text") as! String
        task.state = data.valueForKey("state") as! Int
        
        return task
    }
    
    private func getDailyTasksListObjectFromResponse(response: AnyObject) -> DailyTasksList? {
        let data: NSDictionary = NSDictionary(dictionary: response as! [NSObject : AnyObject])
        let tasks: NSArray = data.valueForKey("tasks") as! NSArray
        
        var dailyTasksList: DailyTasksList = DailyTasksList()
        
        for item in tasks {
            var task: DailyTask = DailyTask()
            task.id = item.valueForKey("_id") as! String
            task.text = item.valueForKey("text") as! String
            task.state = item.valueForKey("state") as! Int
            
            dailyTasksList.dailyTasks.addObject(task)
        }
        
        return dailyTasksList
    }
}
