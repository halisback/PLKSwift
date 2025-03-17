//
//  PLKEvent.swift
//  Pods
//
//  Created by Sapien on 7/4/17.
//
//

import UIKit

public class PLKEvent {
    
    private init() {}
    
    static public func addEventListener(object:Any, eventName:String, selector: Selector) {
        NotificationCenter.default.addObserver(object, selector: selector, name: NSNotification.Name(rawValue: eventName), object: nil)
    }
    
    static public func removeEventListener(object:Any, eventName:String) {
        NotificationCenter.default.removeObserver(object, name: NSNotification.Name(rawValue: eventName), object: nil)
    }
    
    static public func dispatchEvent(eventName:String, object: Any?) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: eventName), object: object)
    }
    
}
