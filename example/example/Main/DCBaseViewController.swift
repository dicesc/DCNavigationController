//
//  DCBaseViewController.swift
//  Stone_swift
//
//  Created by diao chuan on 2019/8/13.
//  Copyright © 2019 diao_test. All rights reserved.
//

import UIKit

class DCBaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "navbar_black_back"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(back))
    }
    
    @objc func back() {
        let _ = navigationController?.popViewController(animated: true)
    }
    
}

