//
//  ViewController.swift
//  Habits
//
//  Created by Atanas Dimitrov on 5/8/15.
//  Copyright (c) 2015 Seishin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        var user: User = User()
        user.email = "test@test.co"
        user.password = "123456"
        user.name = "test"
        
        ApiClient.createUser(user)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

