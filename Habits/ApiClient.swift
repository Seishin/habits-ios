//
//  ApiClient.swift
//  Habits
//
//  Created by Atanas Dimitrov on 5/20/15.
//  Copyright (c) 2015 Seishin. All rights reserved.
//

struct ApiClient {
    
    static func createUser(user: User, onComplete: (result: User?) -> Void) {
        JSONHTTPClient.postJSONFromURLWithString(createUserUrl, bodyData: user.toJSONData()) { (response: AnyObject!, error: JSONModelError!) -> Void in

            var data: NSDictionary = NSDictionary(dictionary: response as! [NSObject : AnyObject])
            
            if error == nil {
                let response = response! as! [NSObject : AnyObject]
                
                var createdUser: User = User()
                createdUser.id = response["_id"] as! String
                createdUser.name = response["name"] as! String
                createdUser.email = response["email"] as! String
                createdUser.token = response["token"] as! String
                
                onComplete(result: createdUser)
            } else {
                onComplete(result: nil)
            }
        }
    }
    
}
