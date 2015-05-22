//
//  User.swift
//  Habits
//
//  Created by Atanas Dimitrov on 5/20/15.
//  Copyright (c) 2015 Seishin. All rights reserved.
//

class User: JSONModel {
    var id: NSString!
    var email: NSString!
    var password: NSString?
    var name: NSString!
    var token: NSString!
    var stats: NSString!
}