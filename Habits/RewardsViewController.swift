//
//  RewardsViewController.swift
//  Habits
//
//  Created by Atanas Dimitrov on 5/28/15.
//  Copyright (c) 2015 Seishin. All rights reserved.
//

class RewardsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, YALTabBarInteracting {
    
    @IBOutlet weak var rewardsTable: UITableView!
    
    private var rewards: [Reward] = [Reward]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNotifications()
        initUI()
    }
    
    func setupNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onRewardsListGetSuccess:", name: notifRewardGetAllSuccess, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onRewardCreateSuccess:", name: notifRewardCreateSuccess, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onRewardBuySuccess:", name: notifRewardBuySuccess, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onRewardRemoveSuccess:", name: notifRewardRemoveSuccess, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onUserLoginSuccess", name: notifUserLoginSuccess, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onUserCreateSuccess", name: notifUserCreationSuccess, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onFailure:", name: notifFailure, object: nil)
    }
    
    func initUI() {
        rewardsTable.delegate = self
        rewardsTable.dataSource = self
        rewardsTable.allowsMultipleSelectionDuringEditing = false
        
        if UserUtils.checkIfUserIsLoggedIn() {
            ApiClient.getRewardsApi().getAllRewards(UserUtils.getUserProfile()!)
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rewards.count
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.Delete {
            var reward: Reward = rewards[indexPath.row]
            ApiClient.getRewardsApi().removeReward(UserUtils.getUserProfile()!, id: reward.id as! String)
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: RewardCell = tableView.dequeueReusableCellWithIdentifier("reward_cell") as! RewardCell
        
        var reward: Reward = rewards[indexPath.row] as Reward
        
        cell.name.text = reward.text as? String
        
        var buyButton: RewardBuyButton = cell.buyButton as! RewardBuyButton
        buyButton.setId(reward.id as! String)
        buyButton.setTitle("Buy (\(reward.gold))", forState: UIControlState.Normal)
        buyButton.addTarget(self, action: "onBuy:", forControlEvents: UIControlEvents.TouchDown)
        
        return cell
    }
    
    func onRewardsListGetSuccess(notification: NSNotification) {
        let rewards: RewardsList = notification.object as! RewardsList
        
        for reward in rewards.rewardsList {
            self.rewards.append(reward as! Reward)
        }
        
        self.rewardsTable.reloadData()
    }
    
    func onRewardCreateSuccess(notification: NSNotification) {
        var reward: Reward = notification.object as! Reward
        self.rewards.insert(reward, atIndex: 0)
        
        self.rewardsTable.beginUpdates()
        var indexPath: NSIndexPath = NSIndexPath(forRow: 0, inSection: 0)
        self.rewardsTable.insertRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Top)
        self.rewardsTable.endUpdates()
    }
    
    func onRewardBuySuccess(notification: NSNotification) {
        var reward: Reward = notification.object as! Reward
        
        var alertView: UIAlertView = UIAlertView()
        alertView.message = "You've successfully bought \(reward.text)!"
        alertView.addButtonWithTitle("Dismiss")
        
        alertView.show()
    }
    
    func onRewardRemoveSuccess(notification: NSNotification) {
        let id: String = notification.object?.valueForKey("id") as! String
        
        for var i = 0; i < rewards.count; i++ {
            if rewards[i].id == id {
                rewards.removeAtIndex(i)
                break
            }
        }
        
        self.rewardsTable.reloadData()
    }
    
    func onBuy(object: AnyObject) {
        var button: RewardBuyButton = object as! RewardBuyButton
        button.buyReward()
    }
    
    func onFailure(notification: NSNotification) {
        var alertView: UIAlertView = UIAlertView()
        alertView.message = (notification.object as! NSDictionary).valueForKey("reason") as? String
        alertView.addButtonWithTitle("Dismiss")
        
        alertView.show()
    }
    
    func onUserCreateSuccess() {
        self.rewards = [Reward]()
        ApiClient.getRewardsApi().getAllRewards(UserUtils.getUserProfile()!)
    }
    
    func onUserLoginSuccess() {
        self.rewards = [Reward]()
        ApiClient.getRewardsApi().getAllRewards(UserUtils.getUserProfile()!)
    }
    
    func onUserLogoutSuccess() {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(0.5 * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) { () -> Void in
            self.tabBarController?.performSegueWithIdentifier("loginSegue", sender: self)
        }
    }
    
    func extraLeftItemDidPressed() {
        self.navigationController?.performSegueWithIdentifier("createRewardSegue", sender: self)
    }
    
    func extraRightItemDidPressed() {
        self.tabBarController?.performSegueWithIdentifier("profileSegue", sender: self)
    }
}
