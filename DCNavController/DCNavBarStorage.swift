//
//  DCNavBarStorage.swift
//  Stone_swift
//
//  Created by diao chuan on 2019/9/10.
//  Copyright © 2019 diao_test. All rights reserved.
//

import UIKit

class DCNavBarStorage: NSObject {
    var barStyle: UIBarStyle?
    var isTranslucent: Bool?
    var tintColor: UIColor?
    var barTintColor: UIColor?
    var shadowImage: UIImage?
    var titleTextAttributes: [NSAttributedString.Key : Any]?
    var backIndicatorImage: UIImage?
    var backIndicatorTransitionMaskImage: UIImage?
    
    var prefersLargeTitles: Bool?
    var largeTitleTextAttributes: [NSAttributedString.Key : Any]?
    
    init(navBar: UINavigationBar) {
        super.init()
        barStyle = navBar.barStyle
        isTranslucent = navBar.isTranslucent
        tintColor = navBar.tintColor
        barTintColor = navBar.barTintColor
        shadowImage = navBar.shadowImage
        titleTextAttributes = navBar.titleTextAttributes
        backIndicatorImage = navBar.backIndicatorImage
        backIndicatorTransitionMaskImage = navBar.backIndicatorTransitionMaskImage
        
        if #available(iOS 11.0, *) {
            prefersLargeTitles = navBar.prefersLargeTitles
            largeTitleTextAttributes = navBar.largeTitleTextAttributes
        }
    }
    
    func recover(navBar: UINavigationBar) {
        if let navBarStyle = barStyle {
            navBar.barStyle = navBarStyle
        }
        if let navBarIsTranslucent = isTranslucent {
            navBar.isTranslucent = navBarIsTranslucent
        }
        navBar.tintColor = tintColor
        navBar.barTintColor = barTintColor
        navBar.shadowImage = shadowImage
        navBar.titleTextAttributes = titleTextAttributes
        navBar.backIndicatorImage = backIndicatorImage
        navBar.backIndicatorTransitionMaskImage = backIndicatorTransitionMaskImage
        
        if #available(iOS 11.0, *) {
            if let navPrefersLargeTitles = prefersLargeTitles {
                navBar.prefersLargeTitles = navPrefersLargeTitles
            }
            navBar.largeTitleTextAttributes = largeTitleTextAttributes
        }
    }
}
