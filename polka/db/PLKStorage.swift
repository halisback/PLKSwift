//
//  PLKStorage.swift
//  JUHU
//
//  Created by Sapien on 5/10/16.
//  Copyright © 2016 JUHU. All rights reserved.
//

import UIKit

public class PLKStorage {

    public static func get(key:String) -> Any? {
        return UserDefaults.standard.object(forKey: key)
    }
    
    public static func set(key:String, object:Any) {
        let defaults = UserDefaults.standard
        defaults.set(object, forKey: key)
        defaults.synchronize()
    }
    
    public static func getInt(key:String) -> Int? {
        return UserDefaults.standard.object(forKey: key) as? Int
    }
    
    public static func getString(key:String) -> String? {
        return UserDefaults.standard.object(forKey: key) as? String
    }
    
    public static func remove(key:String) {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: key)
        defaults.synchronize()
    }
    
}
