//
//  PLKAlert.swift
//
//  Created by Sapien on 4/18/16.
//  Copyright © 2016 Polka. All rights reserved.
//

import UIKit

public class PLKAlert: NSObject {
    
    public static func showAlert(title:String, message:String, controller:UIViewController) {
        let alert:UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        DispatchQueue.main.async {
            controller.present(alert, animated: true, completion: nil)
        }
        
    }
    
    public static func showError(message:String, controller:UIViewController) {
        self.showAlert(title: "Error", message: message, controller: controller)
    }
    
    static private var loader:UIAlertController?
    public static func loaderShow(controller:UIViewController) {
        if(self.loader == nil) {
            self.loader = UIAlertController(title: "   ", message: nil, preferredStyle: .alert)
            
            let indicator = UIActivityIndicatorView(frame: self.loader!.view.bounds)
            indicator.style = .whiteLarge
            indicator.color = UIColor.black
            indicator.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            self.loader!.view.addSubview(indicator)
            indicator.isUserInteractionEnabled = false
            indicator.startAnimating()
        }
        
        DispatchQueue.main.async {
            controller.present(self.loader!, animated: true, completion: nil)
        }
    }
    
    public static func loaderHide() {
        if(self.loader != nil) {
            DispatchQueue.main.async {
                self.loader!.dismiss(animated: true, completion: nil)
                self.loader = nil
            }
        }
    }
    
    
    
    
}
