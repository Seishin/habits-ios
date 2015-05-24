//
//  HabitsApi.swift
//  Habits
//
//  Created by Atanas Dimitrov on 5/23/15.
//  Copyright (c) 2015 Seishin. All rights reserved.
//

// Notifications names
let notifHabitCreateSuccess = "notif_habit_create_success"
let notifHabitGetSuccess = "notif_habit_get_success"
let notifHabitsListGetSuccess = "notif_habits_list_get_success"
let notifHabitRemoveSuccess = "notif_habit_remove_success"
let notifHabitIncrementSuccess = "notif_habit_increment_success"

class HabitsApi {
    
    private static let instance: HabitsApi = HabitsApi()
    private let dateStr: String!
    private let dateFormatter: NSDateFormatter = NSDateFormatter()
    private let habitsBaseUrl = baseUrl + "/habits/"
    
    init() {
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateStr = dateFormatter.stringFromDate(NSDate())
    }
    
    static func getInstance() -> HabitsApi {
        return instance
    }
    
    func createHabit(user: User, habit: Habit) {
        let url: String = habitsBaseUrl + "?userId=" + String(user.id)
        
        JSONHTTPClient.requestHeaders().setValue(user.token, forKey: "Authorization")
        JSONHTTPClient.postJSONFromURLWithString(url, bodyData: habit.toJSONData()) { (response: AnyObject!, error: JSONModelError!) -> Void in
            
            if (error != nil) {
                NotificationsUtils.sendFailureNotification("Cannot create this habit.")
            } else {
                let habit: Habit = self.getHabitObjectFromResponse(response)!
                NotificationsUtils.sendNotificaiton(notifHabitCreateSuccess, object: habit)
            }
        }
    }
    
    func getHabit(user: User, id: String) {
        let url: String = habitsBaseUrl + id + "/"
        
        JSONHTTPClient.requestHeaders().setValue(user.token, forKey: "Authorization")
        JSONHTTPClient.getJSONFromURLWithString(url, params: ["userId": user.id, "date": dateStr]) { (response: AnyObject!, error: JSONModelError!) -> Void in
            
            if (error != nil) {
                NotificationsUtils.sendFailureNotification("Cannot get this habit.")
            } else {
                let habit: Habit = self.getHabitObjectFromResponse(response)!
                NotificationsUtils.sendNotificaiton(notifHabitGetSuccess, object: habit)
            }
        }
    }
    
    func getHabitsList(user: User) {
        let url: String = habitsBaseUrl + "all/"
        
        JSONHTTPClient.requestHeaders().setValue(user.token, forKey: "Authorization")
        JSONHTTPClient.getJSONFromURLWithString(url, params: ["userId": user.id, "date": dateStr]) { (response: AnyObject!, error: JSONModelError!) -> Void in
            
            if (error != nil) {
                NotificationsUtils.sendFailureNotification("Cannot get this habits list.")
            } else {
                let habitsList: HabitsList = self.getHabitssListObjectFromResponse(response)!
                NotificationsUtils.sendNotificaiton(notifHabitsListGetSuccess, object: habitsList)
            }
        }
    }
    
    func removeHabit(user: User, id: String) {
        let url: String = habitsBaseUrl + id + "/?userId=" + String(user.id)
        
        JSONHTTPClient.JSONFromURLWithString(url, method: "DELETE", params: nil, orBodyData: nil, headers: ["Authorization" : user.token]) { (response: AnyObject!, error: JSONModelError!) -> Void in
            
            if (error != nil) {
                NotificationsUtils.sendFailureNotification("Cannot delete this habit.")
            } else {
                let id: String = response.valueForKey("id") as! String
                NotificationsUtils.sendNotificaiton(notifHabitRemoveSuccess, object:["id": id])
            }
        }
    }
    
    func incrementHabit(user: User, id: String) {
        let url: String = habitsBaseUrl + "increment/" + id + "/?userId=" + String(user.id) + "&date=" + dateStr
    
        JSONHTTPClient.requestHeaders().setValue(user.token, forKey: "Authorization")
        JSONHTTPClient.postJSONFromURLWithString(url, params: nil) { (response: AnyObject!, error: JSONModelError!) -> Void in
            
            println(response)
        }
    }
 
    private func getHabitObjectFromResponse(response: AnyObject) -> Habit? {
        var data: NSDictionary = NSDictionary(dictionary: response as! [NSObject : AnyObject])
        
        var habit: Habit = Habit()
        habit.id = data.valueForKey("_id") as! String
        habit.text = data.valueForKey("text") as! String
        habit.state = data.valueForKey("state") as! Int
        
        return habit
    }
    
    private func getHabitssListObjectFromResponse(response: AnyObject) -> HabitsList? {
        let data: NSDictionary = NSDictionary(dictionary: response as! [NSObject : AnyObject])
        let habits: NSArray = data.valueForKey("habits") as! NSArray
        
        var habitsList: HabitsList = HabitsList()
        
        for item in habits {
            var habit: Habit = Habit()
            habit.id = item.valueForKey("_id") as! String
            habit.text = item.valueForKey("text") as! String
            habit.state = item.valueForKey("state") as! Int
            
            habitsList.habitsList.addObject(habit)
        }
        
        return habitsList
    }
}
