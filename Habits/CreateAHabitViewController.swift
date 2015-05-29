//
//  CreateAHabitViewController.swift
//  Habits
//
//  Created by Atanas Dimitrov on 5/29/15.
//  Copyright (c) 2015 Seishin. All rights reserved.
//

class CreateAHabitViewController: UIViewController {
    
    @IBOutlet weak var habitTextField: UITextField!

    override func viewDidLoad() {
        
    }
    
    @IBAction func onSaveTap(sender: AnyObject) {
        if !habitTextField.text.isEmpty {
            let habit: Habit = Habit()
            habit.text = habitTextField.text
            
            ApiClient.getHabitsApi().createHabit(UserUtils.getUserProfile()!, habit: habit)
            self.navigationController?.popViewControllerAnimated(true)
        }
    }
}
