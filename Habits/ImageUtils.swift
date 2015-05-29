//
//  ImageUtils.swift
//  Habits
//
//  Created by Atanas Dimitrov on 5/30/15.
//  Copyright (c) 2015 Seishin. All rights reserved.
//

import Foundation
import UIKit

struct ImageUtils {
    
    static func createCircleImageView(view: UIImageView) -> UIImageView {
        view.layer.cornerRadius = view.frame.size.height / 2
        view.layer.masksToBounds = true
        view.layer.borderWidth = 0
        view.contentMode = UIViewContentMode.ScaleAspectFill
        
        return view
    }
    
    static func scaleImage(image: UIImage, size: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        image.drawInRect(CGRectMake(0, 0, size.width, size.height))
        var newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
}