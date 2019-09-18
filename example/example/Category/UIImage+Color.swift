//
//  UIImage+Color.swift
//  Stone_swift
//
//  Created by diao chuan on 2019/8/16.
//  Copyright © 2019 diao_test. All rights reserved.
//

import UIKit

extension UIImage {
    static func create(color: UIColor,size: CGSize = CGSize.init(width: 1.0, height: 1.0)) -> UIImage? {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, UIScreen.main.scale)
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        context.setFillColor(color.cgColor)
        let resultImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resultImage
    }
    static func create(colorHex: Int, alpha: CGFloat = 1.0, size: CGSize = CGSize.init(width: 1.0, height: 1.0)) -> UIImage? {
        return create(color: UIColor.init(hex: colorHex, alpha: alpha), size: size)
    }
}
