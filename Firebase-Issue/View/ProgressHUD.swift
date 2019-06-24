//
//  IssueDetailViewController.swift
//  Firebase-Issue
//
//  Created by PushpendraSingh on 24/06/19.
//  Copyright © 2019 PushpendraSingh. All rights reserved.
//

import Foundation
import UIKit

public class ProgressHUD: UIVisualEffectView {
    
    var text: String? {
        didSet {
            label!.text = text
        }
    }
  
    var activityIndictor: UIActivityIndicatorView?
    var label: UILabel?
    let vibrancyView: UIVisualEffectView?
    
    public init(text: String) {
      
        activityIndictor = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.whiteLarge)
      	label = UILabel()
      let blurEffect = UIBlurEffect(style: .light)
        self.text = text
        self.vibrancyView = UIVisualEffectView()
        super.init(effect: blurEffect)
        self.setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        activityIndictor = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
     	 label = UILabel()
      let blurEffect = UIBlurEffect(style: .light)
        self.text = ""
        self.vibrancyView = UIVisualEffectView(effect: UIVibrancyEffect(blurEffect: blurEffect))
        super.init(coder: aDecoder)
        self.setup()
    }
    
    func setup() {
        contentView.addSubview(vibrancyView!)
        contentView.addSubview(activityIndictor!)
        contentView.addSubview(label!)
        activityIndictor!.startAnimating()
    }
    
    override public func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        if let superview = self.superview {
            
            let width = superview.frame.size.width / 2.3
            let height: CGFloat = 50.0
            
            self.frame = superview.frame
            self.backgroundColor = UIColor.black
            self.alpha = 0.5
            
            vibrancyView!.frame = self.bounds
            
            let activityIndicatorSize: CGFloat = 40

            
            activityIndictor!.frame.size = CGSize(width: activityIndicatorSize, height: activityIndicatorSize)
            activityIndictor!.center = self.center
            
            layer.masksToBounds = true
            label!.text = text
            label!.textAlignment = NSTextAlignment.center
            label!.frame = CGRect(x: activityIndicatorSize + 5,
                                 y: 0,
                                 width: width - activityIndicatorSize - 15,
                                 height: height)
            label!.textColor = UIColor.gray
            label!.font = UIFont.boldSystemFont(ofSize: 16)
        }
    }
    
    public func show(hud:ProgressHUD) {
        self.isHidden = false
        let rootVC =  self.topViewController()
        rootVC.view.addSubview(hud)
        rootVC.view.bringSubviewToFront(hud)
      }
    
    public func hide() {
        self.isHidden = true
        self.removeFromSuperview()
    }
    
    public func progressHudOnCenter() {
        self.center = CGPoint(x: self.frame.size.width  / 2,
                                     y: self.frame.size.height / 2)
    }
  
  func topViewController() -> UIViewController {
    return topViewController(UIApplication.shared.keyWindow!.rootViewController!)
  }
  
  func topViewController(_ rootViewController: UIViewController) -> UIViewController {
    if rootViewController.presentedViewController == nil {
      return rootViewController
    }
    if type(of: rootViewController.presentedViewController) == UINavigationController.self {
      let navigationController: UINavigationController? = (rootViewController.presentedViewController as? UINavigationController)
      let lastViewController: UIViewController? = navigationController?.viewControllers.last
      return topViewController(lastViewController!)
    }
    let presentedViewController: UIViewController? = (rootViewController.presentedViewController)
    return topViewController(presentedViewController!)
  }
}
 
