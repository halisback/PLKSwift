//
//  PLKLoader.swift
//
//  Created by Sapien on 5/12/16.
//  Copyright © 2016 Polka. All rights reserved.
//

import UIKit

public class PLKLoader: NSObject {
    
    public static let shared = PLKLoader()
    
    private var completionHandler: (()->Void)?
    private var overlay:UIView?
    
    private var window:UIWindow?
    
    public func show(style:UIBlurEffect.Style, cancellable completion:(()->Void)?) {
        if let overlay = self.overlay {
            if overlay.superview != nil {
                return;
            }
        }
        
        completionHandler = completion
        
        let screen = UIScreen.main.bounds
        overlay = UIView(frame: screen)
        self.overlay!.alpha = 0
        
        if window == nil {
            window = UIWindow(frame: screen)
        }
        
        if (!UIAccessibility.isReduceTransparencyEnabled) {
            overlay!.backgroundColor = UIColor.clear
            
            let blurEffect = UIBlurEffect(style: style)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            blurEffectView.frame = overlay!.bounds
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            
            overlay!.addSubview(blurEffectView)
        }
        else {
            overlay!.backgroundColor = UIColor.black
        }
        
        var tint:UIColor = UIColor.black
        window!.backgroundColor = UIColor(white: 1, alpha: 0.02)
        
        if(style == UIBlurEffect.Style.dark) {
            tint = UIColor.white
            window!.backgroundColor = UIColor(white: 0, alpha: 0.02)
        }
        
        let indicator:UIActivityIndicatorView = UIActivityIndicatorView(style: .whiteLarge)
        indicator.color = tint
        
        indicator.translatesAutoresizingMaskIntoConstraints = false
        overlay!.addSubview(indicator)
        
        overlay!.addConstraint(NSLayoutConstraint(item: overlay!, attribute: .centerX, relatedBy: .equal, toItem: indicator, attribute: .centerX, multiplier: 1, constant: 0))
        overlay!.addConstraint(NSLayoutConstraint(item: overlay!, attribute: .centerY, relatedBy: .equal, toItem: indicator, attribute: .centerY, multiplier: 1, constant: 0))
        
        indicator.startAnimating()
        
        if(completionHandler != nil) {
            
            let button:UIButton  = UIButton(type: .system)
            button.tintColor = tint
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setTitle(NSLocalizedString("CANCELAR", comment:""), for: .normal)
            
            overlay!.addSubview(button)
            overlay!.addConstraint(NSLayoutConstraint(item: button, attribute: .centerX, relatedBy: .equal, toItem: indicator, attribute: .centerX, multiplier: 1, constant: 0))
            overlay!.addConstraint(NSLayoutConstraint(item: button, attribute: .top, relatedBy: .equal, toItem: indicator, attribute: .bottom, multiplier: 1, constant: 64))
            
            button.addTarget(self, action: #selector(buttonHandler), for: .touchUpInside)
            
        }
        
        window!.rootViewController = UIViewController()
        
        self.overlay?.alpha = 0.1
        
        window!.rootViewController!.view = self.overlay;
        
        window!.windowLevel = UIWindow.Level.normal
        window!.makeKeyAndVisible()
        
        UIView.animate(withDuration: 0.3, animations: { self.overlay?.alpha = 1 })
    }
    
    public func hide(_ completion:(()->Void)? = nil) {
        if let window = self.window {
            if !window.isHidden {
                UIView.animate(withDuration: 0.3, animations: { self.overlay?.alpha = 0 }) { (success) in
                    self.overlay?.removeFromSuperview()
                    self.window?.isHidden = true
                    
                    DispatchQueue.main.async {
                        completion?()
                    }
                }
                return
            }
        }
        
        DispatchQueue.main.async {
            completion?()
        }
    }
    
    @objc private func buttonHandler() {
        self.hide()
        
        DispatchQueue.main.async {
            self.completionHandler?()
        }
    }
    
}
