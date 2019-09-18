//
//  UIScreen+Frame.swift
//  Stone_swift
//
//  Created by diao chuan on 2019/9/4.
//  Copyright © 2019 diao_test. All rights reserved.
//

import UIKit

extension UIScreen {
   open class var width: CGFloat {
        get {
            return UIScreen.main.bounds.size.width
        }
    }
    open class var height: CGFloat {
        get {
            return UIScreen.main.bounds.size.height
        }
    }
    
}
