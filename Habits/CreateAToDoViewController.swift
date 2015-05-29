//
//  CreateAToDoViewController.swift
//  Habits
//
//  Created by Atanas Dimitrov on 5/29/15.
//  Copyright (c) 2015 Seishin. All rights reserved.
//

class CreateAToDoViewController: UIViewController {

    @IBOutlet weak var toDoTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onSaveTap(sender: AnyObject) {
        if !toDoTextField.text.isEmpty {
            let todo: ToDo = ToDo()
            todo.text = toDoTextField.text
            
            ApiClient.getToDosApi().createToDo(UserUtils.getUserProfile()!, toDo: todo)
            self.navigationController?.popViewControllerAnimated(true)
        }
    }
    
}
