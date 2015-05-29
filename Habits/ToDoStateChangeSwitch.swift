//
//  ToDoStateChangeSwitch.swift
//  Habits
//
//  Created by Atanas Dimitrov on 5/29/15.
//  Copyright (c) 2015 Seishin. All rights reserved.
//

class ToDoStateChangeSwitch: UISwitch {
    private var id: String!
    
    func setId(id: String) {
        self.id = id
    }
    
    func changeState() {
        if on {
            ApiClient.getToDosApi().checkToDo(UserUtils.getUserProfile()!, id: id)
        } else {
            ApiClient.getToDosApi().uncheckToDo(UserUtils.getUserProfile()!, id: id)
        }
    }

}
