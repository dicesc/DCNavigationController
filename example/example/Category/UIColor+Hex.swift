//
//  UIColor+Hex.swift
//  Stone_swift
//
//  Created by diao chuan on 2019/8/16.
//  Copyright © 2019 diao_test. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int, alpha: CGFloat = 1.0) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: alpha)
    }
    
    convenience init(hex: Int, alpha: CGFloat = 1.0) {
        self.init(
            red: (hex >> 16) & 0xFF,
            green: (hex >> 8) & 0xFF,
            blue: hex & 0xFF,
            alpha: alpha
        )
    }
    
    static func random() -> UIColor {
        return UIColor.init(red: Int(arc4random() % 256), green: Int(arc4random() % 256), blue: Int(arc4random() % 256))
    }
}
