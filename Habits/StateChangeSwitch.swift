//
//  StateChangeSwitch.swift
//  Habits
//
//  Created by Atanas Dimitrov on 5/29/15.
//  Copyright (c) 2015 Seishin. All rights reserved.
//

class StateChangeSwitch: UISwitch {
    
    private var id: String!
    
    func setId(id: String) {
        self.id = id
    }
    
    func changeState() {
        if on {
            ApiClient.getDailyTasksApi().checkDailyTask(UserUtils.getUserProfile()!, id: id)
        } else {
            ApiClient.getDailyTasksApi().uncheckDailyTask(UserUtils.getUserProfile()!, id: id)
        }
    }
}
