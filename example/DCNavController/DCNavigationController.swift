//
//  DCNavigation.swift
//  Stone_swift
//
//  Created by diao chuan on 2019/8/13.
//  Copyright © 2019 diao_test. All rights reserved.
//

import UIKit

class DCNavigationController: UINavigationController {
    
    private let screenshotIV = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
    private let shadowView = UIView.init()
    private let coverView = UIView.init()
    private let panGesture = UIScreenEdgePanGestureRecognizer.init()
    
    private let shadowWidth: CGFloat = 10
    private let coverStartAlpha : CGFloat = 0.1
    
    var screenshotImgs: [UIImage] = []
    var navBarStateList: [DCNavBarStorage] = []
    
    override var isNavigationBarHidden: Bool {
        didSet {
            setNavigationBarHidden(isNavigationBarHidden, animated: false)
        }
    }
    
    override func setNavigationBarHidden(_ hidden: Bool, animated: Bool) {
        super.setNavigationBarHidden(hidden, animated: false)
    }
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if viewControllers.count != 0 {
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "返回", style: .plain, target: self, action: #selector(back))
        }
        //截图保存
        if let screenImg = screenshot() {
            screenshotImgs.append(screenImg)
        }
        // 保存当前navBar以及navigationController状态
        navBarStateList.append(DCNavBarStorage.init(navBar: navigationBar))
        super.pushViewController(viewController, animated: animated)
    }
    
    override func popViewController(animated: Bool) -> UIViewController? {
        if !animated {
            screenshotImgs.removeLast()            
        }
        if let navBarState = navBarStateList.last {
            navBarState.recover(navBar: navigationBar)
            navBarStateList.removeLast()
        }
        return super.popViewController(animated: animated)
    }
    override func popToViewController(_ viewController: UIViewController, animated: Bool) -> [UIViewController]? {
        var index = 0
        for i in (viewControllers.count - 1)...0 {
            if viewController == viewControllers[i] {
                index = i
                break
            }
        }
        if !animated {
            screenshotImgs.removeSubrange(index...(screenshotImgs.count - 1))
        } else {
            if index + 1 <= screenshotImgs.count - 1 {
                screenshotImgs.removeSubrange((index + 1)...(screenshotImgs.count - 1))
            }
        }
        return super.popToViewController(viewController, animated: animated)
    }
    override func popToRootViewController(animated: Bool) -> [UIViewController]? {
        if !animated {
            screenshotImgs.removeAll()
        } else {
            let lastIdx = screenshotImgs.count - 1
            screenshotImgs.removeSubrange(1...lastIdx)
        }
        if let navBarState = navBarStateList.first {
            navBarState.recover(navBar: navigationBar)
        }
        navBarStateList.removeAll()
        return super.popToRootViewController(animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
        setup()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
}

extension DCNavigationController {
    
    fileprivate func config() {
        delegate = self
    }
    
    fileprivate func setup() {
        navigationBar.isTranslucent = false
        
        panGesture.edges = UIRectEdge.left
        panGesture.addTarget(self, action: #selector(panHandle))
        view.addGestureRecognizer(panGesture)
        
        coverView.frame = screenshotIV.bounds
        coverView.backgroundColor = .black
        coverView.alpha = coverStartAlpha
        screenshotIV.addSubview(coverView)
        
        shadowView.frame = CGRect.init(x: -shadowWidth, y: 0, width: shadowWidth, height: UIScreen.main.bounds.height)
        screenshotIV.addSubview(shadowView)
        
        let shadowLayer = CAGradientLayer.init()
        shadowView.layer.addSublayer(shadowLayer)
        shadowLayer.colors = [UIColor.clear.cgColor,UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.15).cgColor]
        shadowLayer.startPoint = CGPoint.init(x: 0, y: 0)
        shadowLayer.endPoint = CGPoint.init(x: 1, y: 0)
        shadowLayer.frame = shadowView.bounds
    }
    
    @objc func back() {
       let _ = popViewController(animated: true)
    }
    
    @objc func panHandle() {
        if viewControllers.count == 1 {
            return
        }
        switch panGesture.state {
        case .began:
            beginDrag()
        case .ended:
            endDrag()
        default:
            draging()
        }
    }
    fileprivate func beginDrag() {
        screenshotIV.image = screenshotImgs.last
        view.window!.insertSubview(screenshotIV, at: 0)
    }
    fileprivate func endDrag() {
        let offsetX = panGesture.translation(in: view).x
        if offsetX < UIScreen.main.bounds.width / 2 {
            //弹回
            UIView.animate(withDuration: 0.3, animations: {[weak self] in
                self?.view.transform = CGAffineTransform.identity
                self?.shadowView.transform = CGAffineTransform.identity
                self?.coverView.alpha = self?.coverStartAlpha ?? 0.1
            }) { [weak self] (finished) in
                self?.screenshotIV.removeFromSuperview()
            }
        } else {
            //移动最右边，删除IV，并且调用pop操作
            UIView.animate(withDuration: 0.3, animations: {[weak self] in
                self?.view.transform = CGAffineTransform.init(translationX: UIScreen.main.bounds.width, y: 0)
                let increaseX = self?.shadowWidth ?? 0.0
                self?.shadowView.transform = CGAffineTransform.init(translationX: UIScreen.main.bounds.width + increaseX, y: 0)
                self?.coverView.alpha = 0
            }) { [weak self] (finished) in
                self?.view.transform = CGAffineTransform.identity
                self?.screenshotIV.removeFromSuperview()
                let _ = self?.popViewController(animated: false)
            }
        }
    }
    fileprivate func draging() {
        let offsetX = panGesture.translation(in: view).x
        if offsetX > 0  {
            let offsetPer = offsetX / UIScreen.main.bounds.width
            let shadowIncreaseX = shadowWidth * offsetPer
            view.transform = CGAffineTransform.init(translationX: offsetX, y: 0)
            shadowView.transform = CGAffineTransform.init(translationX: offsetX + shadowIncreaseX, y: 0)
            coverView.alpha =  (1 - offsetPer) * coverStartAlpha
        }
    }
    func screenshot() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, true, UIScreen.main.scale)
        view.drawHierarchy(in: UIScreen.main.bounds, afterScreenUpdates: false)
        let snapshot = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return snapshot
    }
}

extension DCNavigationController: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animationController = DCAnimationController.init()
        animationController.navController = self
        animationController.navOperation = operation
        return animationController
    }

}
