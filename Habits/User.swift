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
    var profileImage: NSString = "http://www.pandatour.com.cn/images/e-02-0731-panda1.jpg"
}