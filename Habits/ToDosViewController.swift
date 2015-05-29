//
//  ToDosViewController.swift
//  Habits
//
//  Created by Atanas Dimitrov on 5/28/15.
//  Copyright (c) 2015 Seishin. All rights reserved.
//

class ToDosViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, YALTabBarInteracting {

    @IBOutlet weak var toDosTable: UITableView!
    
    private var toDos: [ToDo] = [ToDo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNotifications()
        initUI()
    }
    
    func setupNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onToDosListGetSuccess:", name: notifToDosListGetSuccess, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onToDoGetSuccess:", name: notifToDoGetSuccess, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onToDoCreateSuccess:", name: notifToDoCreateSuccess, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onToDoChangeSuccess:", name: notifToDoChangeStateSuccess, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onToDoRemoveSuccess:", name: notifToDoRemoveSuccess, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onFailure:", name: notifFailure, object: nil)
    }
    
    func initUI() {
        toDosTable.delegate = self
        toDosTable.dataSource = self
        toDosTable.allowsMultipleSelectionDuringEditing = false
        
        if UserUtils.checkIfUserIsLoggedIn() {
            ApiClient.getToDosApi().getToDosList(UserUtils.getUserProfile()!)
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDos.count
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.Delete {
            var toDo: ToDo = toDos[indexPath.row]
            ApiClient.getToDosApi().removeToDo(UserUtils.getUserProfile()!, id: toDo.id as! String)
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: ToDoCell = tableView.dequeueReusableCellWithIdentifier("to_do_cell") as! ToDoCell
        
        var toDo: ToDo = toDos[indexPath.row] as ToDo
        
        cell.name.text = toDo.text as? String
        
        var toDoSwitch: ToDoStateChangeSwitch = cell.stateSwitch as ToDoStateChangeSwitch
        if toDo.state == 0 {
            toDoSwitch.setOn(false, animated: true)
        } else if toDo.state == 1 {
            toDoSwitch.setOn(true, animated: true)
        }
        toDoSwitch.setId(toDo.id as! String)
        cell.stateSwitch.addTarget(self, action: "onStateChange:", forControlEvents: UIControlEvents.ValueChanged)
        
        return cell
    }
    
    func onToDosListGetSuccess(notification: NSNotification) {
        let toDos: ToDosList = notification.object as! ToDosList
        
        for task in toDos.toDosList {
            self.toDos.append(task as! ToDo)
        }
        
        self.toDosTable.reloadData()
    }
    
    func onToDoGetSuccess(notification: NSNotification) {
        
    }
    
    func onToDoCreateSuccess(notification: NSNotification) {
        var toDo: ToDo = notification.object as! ToDo
        self.toDos.insert(toDo, atIndex: 0)
        
        self.toDosTable.beginUpdates()
        var indexPath: NSIndexPath = NSIndexPath(forRow: 0, inSection: 0)
        self.toDosTable.insertRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Top)
        self.toDosTable.endUpdates()
    }
    
    func onToDoChangeSuccess(notification: NSNotification) {
        var toDo: ToDo = notification.object as! ToDo
        
        for var i = 0; i < toDos.count; i++ {
            if toDos[i].id == toDo.id as! String {
                toDos[i].state = toDo.state
                break
            }
        }
        
        self.toDosTable.reloadData()
    }
    
    func onToDoRemoveSuccess(notification: NSNotification) {
        let id: String = notification.object?.valueForKey("id") as! String
        
        for var i = 0; i < toDos.count; i++ {
            if toDos[i].id == id {
                toDos.removeAtIndex(i)
                break
            }
        }
        
        self.toDosTable.reloadData()
    }
    
    func onFailure(notification: NSNotification) {
        println(notification)
    }
    
    func onStateChange(object: AnyObject) {
        var stateSwitch: ToDoStateChangeSwitch = object as! ToDoStateChangeSwitch
        stateSwitch.changeState()
        
        self.toDosTable.reloadData()
    }
    
    func extraLeftItemDidPressed() {
        self.navigationController?.performSegueWithIdentifier("createToDoSegue", sender: self)
    }
    
    func extraRightItemDidPressed() {
        self.tabBarController?.performSegueWithIdentifier("profileSegue", sender: self)
    }
}