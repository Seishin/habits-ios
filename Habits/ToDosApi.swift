//
//  ToDosApi.swift
//  Habits
//
//  Created by Atanas Dimitrov on 5/24/15.
//  Copyright (c) 2015 Seishin. All rights reserved.
//

// Notifications names
let notifToDoCreateSuccess = "notif_todo_create_success"
let notifToDoGetSuccess = "notif_todo_get_success"
let notifToDosListGetSuccess = "notif_todos_list_get_success"
let notifToDoRemoveSuccess = "notif_todo_remove_success"
let notifToDoChangeStateSuccess = "notif_todo_change_state_success"

class ToDosApi {
    
    private static let instance: ToDosApi = ToDosApi()
    private let toDoBaseUrl: String = baseUrl + "/todos/"
    
    static func getInstance() -> ToDosApi {
        return instance
    }
    
    init() {}
    
    func createToDo(user: User, toDo: ToDo) {
        let url: String = toDoBaseUrl + "?userId=" + String(user.id)
        
        JSONHTTPClient.requestHeaders().setValue(user.token, forKey: "Authorization")
        JSONHTTPClient.postJSONFromURLWithString(url, bodyData: toDo.toJSONData()) { (response: AnyObject!, error: JSONModelError!) -> Void in
            
            if (error != nil) {
                NotificationsUtils.sendFailureNotification("Cannot create this to do.")
            } else {
                let toDo: ToDo = self.getToDoObjectFromResponse(response)!
                NotificationsUtils.sendNotificaiton(notifToDoCreateSuccess, object: toDo)
            }
        }
    }
    
    func getToDo(user: User, id: String) {
        let url: String = toDoBaseUrl + id + "/?userId=" + String(user.id)
        
        JSONHTTPClient.requestHeaders().setValue(user.token, forKey: "Authorization")
        JSONHTTPClient.getJSONFromURLWithString(toDoBaseUrl, params: nil, completion: { (response: AnyObject!, error: JSONModelError!) -> Void in
            
            if (error != nil) {
                NotificationsUtils.sendFailureNotification("Cannot get this ToDo.")
            } else {
                let toDo: ToDo = self.getToDoObjectFromResponse(response)!
                NotificationsUtils.sendNotificaiton(notifToDoGetSuccess, object: toDo)
            }
        })
    }
    
    func getToDosList(user: User) {
        let url: String = toDoBaseUrl + "all/"
        
        JSONHTTPClient.requestHeaders().setValue(user.token, forKey: "Authorization")
        JSONHTTPClient.getJSONFromURLWithString(url, params: ["userId": user.id]) { (response: AnyObject!, error: JSONModelError!) -> Void in
            
            if (error != nil) {
                NotificationsUtils.sendFailureNotification("Cannot get ToDo list.")
            } else {
                let toDosList: ToDosList = self.getToDosListObjectFromResponse(response)!
                NotificationsUtils.sendNotificaiton(notifToDosListGetSuccess, object: toDosList)
            }
        }
    }
    
    func removeToDo(user: User, id: String) {
        let url: String = toDoBaseUrl + id + "/?userId=" + String(user.id)
        
        JSONHTTPClient.JSONFromURLWithString(url, method: "DELETE", params: nil, orBodyData: nil, headers: ["Authorization": user.token]) { (response: AnyObject!, error: JSONModelError!) -> Void in
            
            if (error != nil) {
                NotificationsUtils.sendFailureNotification("Cannot delete this ToDo.")
            } else {
                let id: String = response.valueForKey("id") as! String
                NotificationsUtils.sendNotificaiton(notifToDoRemoveSuccess, object:["id": id])
            }
        }
    }
    
    func checkToDo(user: User, id: String) {
        let url: String = toDoBaseUrl + id + "/check/?userId=" + String(user.id)
        
        JSONHTTPClient.requestHeaders().setValue(user.token, forKey: "Authorization")
        JSONHTTPClient.postJSONFromURLWithString(url, bodyData: nil) { (response: AnyObject!, error: JSONModelError!) -> Void in
            
            if (error != nil) {
                NotificationsUtils.sendFailureNotification("Cannot check ToDo.")
            } else {
                let toDo: ToDo = self.getToDoObjectFromResponse(response)!
                NotificationsUtils.sendNotificaiton(notifToDoChangeStateSuccess, object: toDo)
            }
        }
    }
    
    func uncheckToDo(user: User, id: String) {
        let url: String = toDoBaseUrl + id + "/uncheck/?userId=" + String(user.id)
        
        JSONHTTPClient.requestHeaders().setValue(user.token, forKey: "Authorization")
        JSONHTTPClient.postJSONFromURLWithString(url, bodyData: nil) { (response: AnyObject!, error: JSONModelError!) -> Void in
            
            if (error != nil) {
                NotificationsUtils.sendFailureNotification("Cannot uncheck ToDo.")
            } else {
                let toDo: ToDo = self.getToDoObjectFromResponse(response)!
                NotificationsUtils.sendNotificaiton(notifToDoChangeStateSuccess, object: toDo)
            }
        }
    }
    
    private func getToDoObjectFromResponse(response: AnyObject) -> ToDo? {
        var data: NSDictionary = NSDictionary(dictionary: response as! [NSObject : AnyObject])
        
        var toDo: ToDo = ToDo()
        toDo.id = data.valueForKey("_id") as! String
        toDo.text = data.valueForKey("text") as! String
        toDo.state = data.valueForKey("state") as! Int
        
        return toDo
    }
    
    private func getToDosListObjectFromResponse(response: AnyObject) -> ToDosList? {
        let data: NSDictionary = NSDictionary(dictionary: response as! [NSObject : AnyObject])
        let toDos: NSArray = data.valueForKey("todos") as! NSArray
        
        var toDosList: ToDosList = ToDosList()
        
        for item in toDos {
            var toDo: ToDo = ToDo()
            toDo.id = item.valueForKey("_id") as! String
            toDo.text = item.valueForKey("text") as! String
            toDo.state = item.valueForKey("state") as! Int
            
            toDosList.toDosList.addObject(toDo)
        }
        
        return toDosList
    }
}