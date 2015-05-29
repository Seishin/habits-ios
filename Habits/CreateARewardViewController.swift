//
//  CreateARewardViewController.swift
//  Habits
//
//  Created by Atanas Dimitrov on 5/30/15.
//  Copyright (c) 2015 Seishin. All rights reserved.
//

class CreateARewardViewController: UIViewController {
    
    @IBOutlet weak var rewardTextField: UITextField!
    @IBOutlet weak var rewardPriceTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onSaveTap(sender: AnyObject) {
        if !rewardTextField.text.isEmpty && !rewardPriceTextField.text.isEmpty {
            let reward: Reward = Reward()
            reward.text = rewardTextField.text
            reward.gold = String(rewardPriceTextField.text).toInt()
            
            ApiClient.getRewardsApi().createReward(UserUtils.getUserProfile()!, reward: reward)
            self.navigationController?.popViewControllerAnimated(true)
        }
    }
}