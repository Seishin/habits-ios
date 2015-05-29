//
//  RewardBuyButton.swift
//  Habits
//
//  Created by Atanas Dimitrov on 5/30/15.
//  Copyright (c) 2015 Seishin. All rights reserved.
//

class RewardBuyButton: UIButton {
    private var id: String!
    
    func setId(id: String) {
        self.id = id
    }
    
    func buyReward() {
        ApiClient.getRewardsApi().buyReward(UserUtils.getUserProfile()!, id: id)
    }
}
