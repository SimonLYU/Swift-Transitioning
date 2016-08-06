//
//  LYUTransitionAnimater.swift
//  highGo2
//
//  Created by 吕旭明 on 16/8/6.
//  Copyright © 2016年 lyu. All rights reserved.
//

import UIKit

// MARK:- 面向协议
///负责获取跳转动画相关的参数
protocol LYUPresentAnimationDelegate {
    func getImageView(indexPath : NSIndexPath) -> UIImageView
    func getStartRect(indexPath : NSIndexPath) -> CGRect
    func getEndRect(indexPath : NSIndexPath) -> CGRect
}
///负责消失动画相关的参数
protocol LYUDismissAnimationDelegate {
    func getIndexPath() -> NSIndexPath
    func getImageView() -> UIImageView
}


class LYUTransitionAnimater: NSObject {
    
    //present代理
    var presentDelegate : LYUPresentAnimationDelegate?
    //dismiss代理
    var dismissDelegate : LYUDismissAnimationDelegate?
    //有外界传值,负责确定跳转动画的初始位置
    var indexPath : NSIndexPath?
    //控制present或dismiss
    var isPresenting = true
    //单例
    static let shareAnimater = LYUTransitionAnimater()

}

// MARK:- transtionDelegate
extension LYUTransitionAnimater : UIViewControllerTransitioningDelegate{
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresenting = true
        return self
    }
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresenting = false
        return self
    }
    
}

// MARK:- animatedTransitioning
extension LYUTransitionAnimater : UIViewControllerAnimatedTransitioning{
    //控制动画时间
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 1.5
    }
    //控制动画效果
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        if isPresenting {
            //拿到即将跳转的view
            let presentView = transitionContext.viewForKey(UITransitionContextToViewKey)!
            //防呆
            guard let presentDelegate = presentDelegate , indexPath = indexPath else {
                return
            }
            //拿到用于执行动画的imageView
            let animationImageView = presentDelegate.getImageView(indexPath)
            //动画开始的第一步,让用户看collectionView不到其他不和谐的元素
            transitionContext.containerView()?.backgroundColor = UIColor.blackColor()
            //获取imageView的初始位置,以此来做动画
            animationImageView.frame = presentDelegate.getStartRect(indexPath)
            transitionContext.containerView()?.addSubview(animationImageView)
            //获取动画时间
            let duration = transitionDuration(transitionContext)
            UIView.animateWithDuration(duration, animations: { 
                animationImageView.frame = presentDelegate.getEndRect(indexPath)
                }, completion: { (_) in
                    transitionContext.containerView()?.backgroundColor = UIColor.clearColor()  //重新透明化
                    animationImageView.removeFromSuperview()  //移除制作动画的animationImageView
                    transitionContext.containerView()?.addSubview(presentView)
                    transitionContext.completeTransition(true)  //完成动画
            })
        }
        else
        {
            //拿到即将消失的view
            let dismissView = transitionContext.viewForKey(UITransitionContextFromViewKey)!
            dismissView.removeFromSuperview()
            guard let dismissDelegate = dismissDelegate else {
                return
            }
            //获取imageView
            let imageView = dismissDelegate.getImageView()
            let duration = transitionDuration(transitionContext)
            let indexpath = dismissDelegate.getIndexPath()
            let endRect = presentDelegate?.getStartRect(indexpath)
            
            
            //开始动画
            transitionContext.containerView()?.addSubview(imageView)
            UIView.animateWithDuration(duration, animations: {
                //判断indexPath指向的cell在LYUMainCVC中是否越界
                if endRect == CGRectZero {
                    imageView.frame = CGRectMake(UIScreen.mainScreen().bounds.width * 0.5, UIScreen.mainScreen().bounds.height, 0, 0)
                }
                else {
                    imageView.frame = endRect!
                }
                }, completion: { (_) in
                    imageView.removeFromSuperview()
                    transitionContext.completeTransition(true)
            })
        }
    }
}
