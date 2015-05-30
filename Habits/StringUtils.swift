//
//  StringUtils.swift
//  Habits
//
//  Created by Atanas Dimitrov on 5/30/15.
//  Copyright (c) 2015 Seishin. All rights reserved.
//

struct StringUtils {
    
    static func getPluralisedString(let number: Int, let singularStr: String, let pluralStr: String) -> String {
        if number == 1 {
            return "\(number) " + singularStr
        } else {
            return "\(number) " + pluralStr
        }
    }
    
    static func validateEmail(let email: String) -> Bool {
        let emailRegex: String = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluateWithObject(email)
    }
}