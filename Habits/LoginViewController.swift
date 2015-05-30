//
//  LoginViewController.swift
//  Habits
//
//  Created by Atanas Dimitrov on 5/29/15.
//  Copyright (c) 2015 Seishin. All rights reserved.
//

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    private var alertView: UIAlertView!
    
    override func viewDidLoad() {
        setupNotifications()
        initAlertView()
    }
    
    func setupNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onLoginSuccess:", name: notifUserLoginSuccess, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onRegisterSuccess:", name: notifUserCreationSuccess, object: nil)
    }
    
    func initAlertView() {
        alertView = UIAlertView()
        alertView.addButtonWithTitle("Dismiss")
    }
    
    @IBAction func onLoginTap(sender: AnyObject) {
        if !emailField.text.isEmpty && !passwordField.text.isEmpty {
            if StringUtils.validateEmail(emailField.text) {
                let user: User = User()
                user.email = emailField.text
                user.password = passwordField.text
                
                ApiClient.getUsersApi().loginUser(user)
            } else {
                alertView.message = "Invalid email"
                alertView.show()
            }
        } else {
            alertView.message = "Please enter email and password"
            alertView.show()
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