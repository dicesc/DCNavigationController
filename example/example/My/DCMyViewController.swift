//
//  DCMyViewController.swift
//  example
//
//  Created by diao chuan on 2019/9/16.
//  Copyright © 2019 diao_test. All rights reserved.
//

import UIKit

class DCMyViewController: DCBaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.navigationItem.title = "隐藏"
        tabBarController?.navigationController?.setNavigationBarHidden(false, animated: animated)
    }

}

extension DCMyViewController {
    fileprivate func setup() {
        let btn = UIButton.init(type: .custom)
        btn.setTitle("下一页", for: UIControl.State.normal)
        btn.backgroundColor = .red
        btn.addTarget(self, action: #selector(DCMyViewController.clickNextPage), for: UIControl.Event.touchUpInside)
        view.addSubview(btn)
        btn.frame = CGRect.init(x: 100, y: 30, width: 150, height: 100)
    }
    
    @objc func clickNextPage(){
        let newVC = DCMyDetailViewController.init()
        newVC.title = "第二页"
        navigationController?.pushViewController(newVC, animated: true)
    }
}

