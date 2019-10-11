//
//  DCAnimationController.swift
//  Stone_swift
//
//  Created by diao chuan on 2019/9/6.
//  Copyright © 2019 diao_test. All rights reserved.
//

import UIKit

class DCAnimationController: NSObject, UIViewControllerAnimatedTransitioning{
    
    var navOperation: UINavigationController.Operation = .none
    weak var navController: DCNavigationController!
    private let coverView = UIView.init(frame: UIScreen.main.bounds)
    private let durationTime = 0.3
    private let screenBounds = UIScreen.main.bounds
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return durationTime
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        let toView = transitionContext.view(forKey: UITransitionContextViewKey.to)!
        let containerView = transitionContext.containerView
        
        let screenIV = UIImageView.init(frame: screenBounds)
        coverView.backgroundColor = .black
        screenIV.addSubview(coverView)

        if navOperation == .push {
            coverView.alpha = 0
            screenIV.image = navController.screenshotImgs.last
            // 原截图盖在fromView之上
            navController.view.window!.insertSubview(screenIV, at: 0)
            // 设置toView的位置在屏幕最右端
            containerView.addSubview(toView)
            toView.frame = transitionContext.finalFrame(for: toVC)
            navController.view.transform = CGAffineTransform.init(translationX: screenBounds.width, y: 0)
            
            let toScreenIV = UIImageView.init(frame: CGRect.init(x:screenBounds.width , y: 0, width: screenBounds.width, height: screenBounds.height))
            containerView.addSubview(toScreenIV)
            // 执行动画移动到末端位置
            UIView.animate(withDuration: durationTime, animations: {[weak self] in
                self?.navController.view.transform = CGAffineTransform.identity
                toScreenIV.frame = UIScreen.main.bounds
                self?.coverView.alpha = 0.1
            }) { _ in
                // 动画结束移除截图覆盖
                screenIV.removeFromSuperview()
                toScreenIV.removeFromSuperview()
                transitionContext.completeTransition(true)
            }
            
        } else if navOperation == .pop {
            screenIV.image = navController.screenshotImgs.last
            coverView.alpha = 0.1
            // 原截图盖在fromView之上
            navController.view.addSubview(screenIV)
            // 屏幕截图 覆盖屏幕最上层
            let fromScreenIV = UIImageView.init(frame: screenBounds)
            fromScreenIV.image = navController.view.screenshot()
            navController.view.window!.addSubview(fromScreenIV)
            // 设置toView的位置
            containerView.addSubview(toView)
            toView.frame = transitionContext.finalFrame(for: toVC)
            
            // 执行动画移动到末端位置
            UIView.animate(withDuration: durationTime, animations: {[weak self] in
                fromScreenIV.frame = CGRect.init(x: UIScreen.main.bounds.width, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                self?.coverView.alpha = 0
            }) {[weak self] _ in
                // 动画结束移除截图覆盖
                fromScreenIV.removeFromSuperview()
                screenIV.removeFromSuperview()
                self?.navController.screenshotImgs.removeLast()
                transitionContext.completeTransition(true)
            }
        }
        
    }
}
