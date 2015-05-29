//
//  DailyTasks.swift
//  Habits
//
//  Created by Atanas Dimitrov on 5/28/15.
//  Copyright (c) 2015 Seishin. All rights reserved.
//

class DailyTasksViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, YALTabBarInteracting {
    
    @IBOutlet weak var dailyTasksTable: UITableView!
    
    private var dailyTasks: [DailyTask] = [DailyTask]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNotifications()
        initUI()
    }
    
    func setupNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onDailyTasksListGetSuccess:", name: notifDailyTasksListGetSuccess, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onDailyTaskGetSuccess:", name: notifDailyTaskGetSuccess, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onDailyTaskCreateSuccess:", name: notifDailyTaskCreateSuccess, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onDailyTaskChangeSuccess:", name: notifDailyTaskChangeStateSuccess, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onDailyTaskRemoveSuccess:", name: notifDailyTaskRemove, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onUserLoginSuccess", name: notifUserLoginSuccess, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onUserCreateSuccess", name: notifUserCreationSuccess, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onFailure:", name: notifFailure, object: nil)
    }
    
    func initUI() {
        dailyTasksTable.delegate = self
        dailyTasksTable.dataSource = self
        dailyTasksTable.allowsMultipleSelectionDuringEditing = false
        
        if UserUtils.checkIfUserIsLoggedIn() {
            ApiClient.getDailyTasksApi().getDailyTasks(UserUtils.getUserProfile()!)
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dailyTasks.count
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }

    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.Delete {
            var task: DailyTask = dailyTasks[indexPath.row]
            ApiClient.getDailyTasksApi().removeDailyTask(UserUtils.getUserProfile()!, id: task.id as! String)
        }
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: DailyTaskCell = tableView.dequeueReusableCellWithIdentifier("daily_task_cell") as! DailyTaskCell
        
        var task: DailyTask = dailyTasks[indexPath.row] as DailyTask
        
        cell.name.text = task.text as? String
        
        var stateSwitch: StateChangeSwitch = cell.taskState as! StateChangeSwitch
        if task.state == 0 {
            stateSwitch.setOn(false, animated: true)
        } else if task.state == 1 {
            stateSwitch.setOn(true, animated: true)
        }
        stateSwitch.setId(task.id as! String)
        cell.taskState.addTarget(self, action: "onStateChange:", forControlEvents: UIControlEvents.ValueChanged)

        return cell
    }
    
    func onDailyTasksListGetSuccess(notification: NSNotification) {
        let tasks: DailyTasksList = notification.object as! DailyTasksList
        
        for task in tasks.dailyTasks {
            self.dailyTasks.append(task as! DailyTask)
        }
        
        self.dailyTasksTable.reloadData()
    }
    
    func onDailyTaskGetSuccess(notification: NSNotification) {
    
    }
    
    func onDailyTaskCreateSuccess(notification: NSNotification) {
        var task: DailyTask = notification.object as! DailyTask
        self.dailyTasks.insert(task, atIndex: 0)
        
        self.dailyTasksTable.beginUpdates()
        var indexPath: NSIndexPath = NSIndexPath(forRow: 0, inSection: 0)
        self.dailyTasksTable.insertRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Top)
        self.dailyTasksTable.endUpdates()
    }
    
    func onDailyTaskChangeSuccess(notification: NSNotification) {
        var task: DailyTask = notification.object as! DailyTask
        
        for var i = 0; i < dailyTasks.count; i++ {
            if dailyTasks[i].id == task.id as! String {
                dailyTasks[i].state = task.state
                break
            }
        }
        
        self.dailyTasksTable.reloadData()
    }
    
    func onDailyTaskRemoveSuccess(notification: NSNotification) {
        let id: String = notification.object?.valueForKey("id") as! String
        
        for var i = 0; i < dailyTasks.count; i++ {
            if dailyTasks[i].id == id {
                dailyTasks.removeAtIndex(i)
                break
            }
        }
        
        self.dailyTasksTable.reloadData()
    }
    
    func onFailure(notification: NSNotification) {
        var alertView: UIAlertView = UIAlertView()
        alertView.message = (notification.object as! NSDictionary).valueForKey("reason") as? String
        alertView.addButtonWithTitle("Dismiss")
        
        alertView.show()
    }
    
    func onStateChange(object: AnyObject) {
        var stateSwitch: StateChangeSwitch = object as! StateChangeSwitch
        stateSwitch.changeState()
        
        self.dailyTasksTable.reloadData()
    }
    
    func onUserCreateSuccess() {
        self.dailyTasks = [DailyTask]()
        ApiClient.getDailyTasksApi().getDailyTasks(UserUtils.getUserProfile()!)
    }
    
    func onUserLoginSuccess() {
        self.dailyTasks = [DailyTask]()
        ApiClient.getDailyTasksApi().getDailyTasks(UserUtils.getUserProfile()!)
    }
    
    func onUserLogoutSuccess() {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(0.5 * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) { () -> Void in
            self.tabBarController?.performSegueWithIdentifier("loginSegue", sender: self)
        }
    }
    
    func extraLeftItemDidPressed() {
        self.navigationController?.performSegueWithIdentifier("createDailyTaskSegue", sender: self)
    }
    
    func extraRightItemDidPressed() {
        self.tabBarController?.performSegueWithIdentifier("profileSegue", sender: self)
    }
}
