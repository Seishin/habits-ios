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
    
    private var alertView: UIAlertView!
    
    override func viewDidLoad() {
        setupNotifications()
        initAlertView()
    }
    
    func setupNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onRegisterSuccess:", name: notifUserCreationSuccess, object: nil)
    }
    
    func initAlertView() {
        alertView = UIAlertView()
        alertView.addButtonWithTitle("Dismiss")
    }
    
    @IBAction func onRegisterTap(sender: AnyObject) {
        if !emailField.text.isEmpty && !passwordField.text.isEmpty && !nameField.text.isEmpty {
            if StringUtils.validateEmail(emailField.text) {
                let user: User = User()
                user.email = emailField.text
                user.password = passwordField.text
                user.name = nameField.text
                ApiClient.getUsersApi().createUser(user)
            } else {
                alertView.message = "Invalid email!"
                alertView.show()
            }
        } else {
            alertView.message = "Please enter email or password!"
            alertView.show()
        }
    }
    
    @IBAction func onCloseTap(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func onRegisterSuccess(notification: NSNotification) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
