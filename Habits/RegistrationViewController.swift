//
//  RegistrationViewController.swift
//  Habits
//
//  Created by Atanas Dimitrov on 5/29/15.
//  Copyright (c) 2015 Seishin. All rights reserved.
//

class RegistrationViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    
    override func viewDidLoad() {
        setupNotifications()
    }
    
    func setupNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onRegisterSuccess:", name: notifUserCreationSuccess, object: nil)
    }
    
    @IBAction func onRegisterTap(sender: AnyObject) {
        if !emailField.text.isEmpty && !passwordField.text.isEmpty && !nameField.text.isEmpty {
            let user: User = User()
            user.email = emailField.text
            user.password = passwordField.text
            user.name = nameField.text
            ApiClient.getUsersApi().createUser(user)
        }
    }
    
    @IBAction func onCloseTap(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func onRegisterSuccess(notification: NSNotification) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
