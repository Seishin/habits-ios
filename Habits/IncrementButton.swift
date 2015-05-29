//
//  IncrementButton.swift
//  Habits
//
//  Created by Atanas Dimitrov on 5/29/15.
//  Copyright (c) 2015 Seishin. All rights reserved.
//

class IncrementButton: UIButton {
    
    private var id: String!
    
    func setId(id: String) {
        self.id = id
    }
    
    func performIncrementAction() {
        ApiClient.getHabitsApi().incrementHabit(UserUtils.getUserProfile()!, id: self.id)
    }
}
