//
//  LoginViewController.swift
//  Habits
//
//  Created by Atanas Dimitrov on 5/29/15.
//  Copyright (c) 2015 Seishin. All rights reserved.
//

class LoginViewController: UIViewController {
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        setupNotifications()
    }
    
    func setupNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onLoginSuccess:", name: notifUserLoginSuccess, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onRegisterSuccess:", name: notifUserCreationSuccess, object: nil)
    }
    
    @IBAction func onLoginTap(sender: AnyObject) {
        if !usernameField.text.isEmpty && !passwordField.text.isEmpty {
            let user: User = User()
            user.email = usernameField.text
            user.password = passwordField.text
            
            ApiClient.getUsersApi().loginUser(user)
        }
    }
    
    @IBAction func onRegistrationTap(sender: AnyObject) {

    }
    
    func onLoginSuccess(notification: NSNotification) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func onRegisterSuccess(notification: NSNotification) {
        dispatch_async(dispatch_get_main_queue()) {
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
}