//
//  UIView+Frame.swift
//  Stone_swift
//
//  Created by diao chuan on 2019/9/4.
//  Copyright © 2019 diao_test. All rights reserved.
//

import UIKit

extension UIView {
    var width: CGFloat {
        get{
            return bounds.size.width
        }
    }
    var height: CGFloat {
        get {
            return bounds.size.height
        }
    }
    var x: CGFloat {
        get {
            return frame.origin.x
        }
    }
    var y: CGFloat {
        get {
            return frame.origin.y
        }
    }
}
