//
//  ViewController.swift
//  Habits
//
//  Created by Atanas Dimitrov on 5/8/15.
//  Copyright (c) 2015 Seishin. All rights reserved.
//

import UIKit

class HabitsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, YALTabBarInteracting {

    @IBOutlet weak var habitsTable: UITableView!
    
    private var habits: [Habit] = [Habit]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNotifications()
        initUI()
    }
    
    func setupNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onHabitsObtainSuccess:", name: notifHabitsListGetSuccess, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onHabitCreateSuccess:", name: notifHabitCreateSuccess, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onHabitIncrementSuccess:", name: notifHabitIncrementSuccess, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onHabitRemoveSuccess:", name: notifHabitRemoveSuccess, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onFailure:", name: notifFailure, object: nil)
    }
    
    func initUI() {
        habitsTable.delegate = self
        habitsTable.dataSource = self
        habitsTable.allowsMultipleSelectionDuringEditing = false
        
        if UserUtils.checkIfUserIsLoggedIn() {
            ApiClient.getHabitsApi().getHabitsList(UserUtils.getUserProfile()!)
        }
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return habits.count
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.Delete {
            var habit: Habit = habits[indexPath.row]
            ApiClient.getHabitsApi().removeHabit(UserUtils.getUserProfile()!, id: habit.id as String)
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: HabitCell = tableView.dequeueReusableCellWithIdentifier("habits_cell") as! HabitCell
        
        var habit: Habit = habits[indexPath.row] as Habit
        
        cell.name.text = habit.text as? String
        
        if habit.state == 0 {
            cell.backgroundColor = UIColor.blueColor()
        } else if habit.state == 1 {
            cell.backgroundColor = UIColor.yellowColor()
        } else if habit.state == 2 {
            cell.backgroundColor = UIColor.greenColor()
        }
        
        var incButton: IncrementButton = cell.incrementButton as! IncrementButton
        incButton.setId(habit.id as! String)
        incButton.addTarget(self, action: "onIncrement:", forControlEvents: UIControlEvents.TouchDown)
        
        return cell
    }
    
    func onHabitsObtainSuccess(notification: NSNotification) {
        let habits: HabitsList = notification.object as! HabitsList
        
        for habit in habits.habitsList {
            self.habits.append(habit as! Habit)
        }
        
        self.habitsTable.reloadData()
    }
    
    func onHabitCreateSuccess(notification: NSNotification) {
        var habit: Habit = notification.object as! Habit
        self.habits.insert(habit, atIndex: 0)
        
        self.habitsTable.beginUpdates()
        var indexPath: NSIndexPath = NSIndexPath(forRow: 0, inSection: 0)
        self.habitsTable.insertRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Top)
        self.habitsTable.endUpdates()
    }
    
    func onHabitIncrementSuccess(notification: NSNotification) {
        var habit: Habit = notification.object as! Habit
        
        for var i = 0; i < self.habits.count; i++ {
            if habits[i].id == habit.id {
                habits[i].state = habit.state
            }
        }
        
        self.habitsTable.reloadData()
    }
    
    func onHabitRemoveSuccess(notification: NSNotification) {
        let id: String = notification.object?.valueForKey("id") as! String
        
        for var i = 0; i < habits.count; i++ {
            if habits[i].id == id {
                habits.removeAtIndex(i)
                break
            }
        }
        
        self.habitsTable.reloadData()
    }
    
    func onFailure(notification: NSNotification) {
        println(notification)
    }
    
    func onIncrement(object: AnyObject) {
        (object as! IncrementButton).performIncrementAction()
    }
    
    func extraLeftItemDidPressed() {
        self.navigationController?.performSegueWithIdentifier("addHabitSegue", sender: self)
    }
}

