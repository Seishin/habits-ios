//
//  ApiClient.swift
//  Habits
//
//  Created by Atanas Dimitrov on 5/20/15.
//  Copyright (c) 2015 Seishin. All rights reserved.
//

import Foundation

struct ApiClient {
    
    static func createUser(user: User) {
        println(user.toJSONString())
        
        JSONHTTPClient.requestHeaders().setValue(user.token, forKey: "AuthorizationToken")
        JSONHTTPClient.postJSONFromURLWithString(createUserUrl, bodyData: user.toJSONData()) { (response: AnyObject!, error: JSONModelError!) -> Void in
            println(response)
        }
    }
    
}
