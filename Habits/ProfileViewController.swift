//
//  ProfileViewController.swift
//  Habits
//
//  Created by Atanas Dimitrov on 5/28/15.
//  Copyright (c) 2015 Seishin. All rights reserved.
//

class ProfileViewController: UIViewController {

    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var level: UILabel!
    @IBOutlet weak var experience: UILabel!
    @IBOutlet weak var hp: UILabel!
    @IBOutlet weak var gold: UILabel!
    
    var tabsController: UITabBarController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configNotifications()
        initUI();
    }
    
    func configNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onUserStatsObtained:", name: notifUserStatsGetSuccess, object: nil)
    }
    
    func initUI() {
        if UserUtils.checkIfUserIsLoggedIn() {
            ApiClient.getUserStatsApi().getStats(UserUtils.getUserProfile()!)
            
            self.avatar = ImageUtils.createCircleImageView(self.avatar)
            self.avatar.startLoader()
            self.avatar.sd_setImageWithURL(NSURL(string: UserUtils.getUserProfile()!.profileImage as! String)!, placeholderImage: nil,  options:SDWebImageOptions.CacheMemoryOnly | SDWebImageOptions.RefreshCached, progress: { (receivedSize: Int, expectedSize: Int) -> Void in
                self.avatar.updateImageDownloadProgress(CGFloat(receivedSize / expectedSize))
                }) { (image: UIImage!, error: NSError!, cacheType: SDImageCacheType, imageUrl: NSURL!) -> Void in
                    self.avatar.reveal()
            }
            self.name.text = UserUtils.getUserProfile()!.name as? String
        }
    }
    
    func onUserStatsObtained(notification: NSNotification) {
        var stats: UserStats = notification.object as! UserStats
        
        level.text = String(stats.lvl)
        experience.text = "\(stats.exp)/\(stats.maxLvlExp)"
        hp.text = String(stats.hp)
        gold.text = String(stats.gold)
    }
    
    @IBAction func onCloseTap(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func onLogoutTap(sender: AnyObject) {
        UserUtils.logout()
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
