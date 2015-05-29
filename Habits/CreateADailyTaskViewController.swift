//
//  CreateADailyTaskViewController.swift
//  Habits
//
//  Created by Atanas Dimitrov on 5/29/15.
//  Copyright (c) 2015 Seishin. All rights reserved.
//

class CreateADailyTaskViewController: UIViewController {
    
    @IBOutlet weak var dailyTaskField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onSaveTap(sender: AnyObject) {
        if !dailyTaskField.text.isEmpty {
            let task: DailyTask = DailyTask()
            task.text = dailyTaskField.text
            
            ApiClient.getDailyTasksApi().createDailyTask(UserUtils.getUserProfile()!, dailyTask: task)
            
            self.navigationController?.popViewControllerAnimated(true)
        }
    }
}
