//
//  DCBaseViewController.swift
//  Stone_swift
//
//  Created by diao chuan on 2019/8/13.
//  Copyright © 2019 diao_test. All rights reserved.
//

import UIKit

class DCBaseViewController: UIViewController {
    let navItem: UINavigationItem = UINavigationItem.init()
    let navBar: UINavigationBar = UINavigationBar.init()
    let navBackgroundView: UIView = UIView.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
}

