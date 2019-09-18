//
//  DCMyDetailViewController.swift
//  example
//
//  Created by diao chuan on 2019/9/16.
//  Copyright © 2019 diao_test. All rights reserved.
//

import UIKit

class DCMyDetailViewController: DCBaseViewController {

   
    var count: Int = 3
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        navigationController?.navigationBar.barTintColor = UIColor.random()
        if count % 2 == 1 {
            navigationController?.navigationBar.tintColor = .white
        } else {
            navigationController?.navigationBar.tintColor = .red
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(count % 2 == 1 ? true : false, animated: animated)
        
    }

}
extension DCMyDetailViewController {
    fileprivate func setup() {
        let btn = UIButton.init(type: .custom)
        btn.setTitle("下一页", for: UIControl.State.normal)
        btn.backgroundColor = .random()
        btn.addTarget(self, action: #selector(DCMyDetailViewController.clickNextPage), for: UIControl.Event.touchUpInside)
        view.addSubview(btn)
        btn.frame = CGRect.init(x: 100, y: 30, width: 150, height: 100)
    }
    
    @objc func clickNextPage(){
        let newVC = DCMyDetailViewController.init()
        newVC.title = "第\(count)页"
        newVC.count = count + 1
        navigationController?.pushViewController(newVC, animated: true)
    }
    @objc func goBack() {
        navigationController?.popViewController(animated: true)
    }
}
