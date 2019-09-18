//
//  UIImage+Resize.swift
//  Stone_swift
//
//  Created by diao chuan on 2019/8/16.
//  Copyright © 2019 diao_test. All rights reserved.
//

import UIKit

extension UIImage {
    
    //ImageIO
    func resizeIO(size:CGSize) -> UIImage? {
        
        guard let data = self.pngData() else { return nil }
        
        let maxPixelSize = max(size.width, size.height)
        
        //let imageSource = CGImageSourceCreateWithURL(url, nil)
        guard let imageSource = CGImageSourceCreateWithData(data as CFData, nil) else { return nil }
        
        //kCGImageSourceThumbnailMaxPixelSize为生成缩略图的大小。当设置为800，如果图片本身大于800*600，则生成后图片大小为800*600，如果源图片为700*500，则生成图片为800*500
        let options: [NSString: Any] = [
            kCGImageSourceThumbnailMaxPixelSize: maxPixelSize,
            kCGImageSourceCreateThumbnailFromImageAlways: true
        ]
        
        let resizedImage = CGImageSourceCreateImageAtIndex(imageSource, 0, options as CFDictionary).flatMap{
            UIImage(cgImage: $0)
        }
        return resizedImage
    }
}
