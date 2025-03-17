//
//  PLKRest.swift
//
//  Created by Sapien on 4/13/16.
//  Copyright © 2016 Polka. All rights reserved.
//

import Foundation
import SwiftyJSON

public enum PLKRestMethods : String {
    case GET
    case POST
    case PUT
    case DELETE
}

public class PLKRest : NSObject {
    
    var url:URL?
    var method:PLKRestMethods
    
    var session:URLSession?
    
    public var task:URLSessionDataTask?

    public init(url:String, method:PLKRestMethods = .GET) {
        self.url    = URL(string: url)
        self.method = method
        
        let configuration = URLSessionConfiguration.default
        self.session = URLSession(configuration: configuration)
    }
    
    private var _header:Dictionary<String,String>?
    
    public func setHeader(params:Dictionary<String,String>) -> PLKRest {
        _header = params
        return self
    }
    
    private var _formData:Dictionary<String,String>?
    
    public func setFormData(params:Dictionary<String,String>) -> PLKRest {
        _formData = params
        return self
    }
    
    public func cancelTask() {
        if task != nil {
            task?.cancel()
            task = nil
        }
    }
    
    
    public func executeWithData(completion: @escaping (_ data: Data?, _ response: URLResponse?) -> Void) {
        self.cancelTask()
        
        guard let s = self.session, let req = getRequest() else {
            DispatchQueue.main.sync {
                completion(nil, nil)
            }
            return
        }
        
        task = s.dataTask(with:req, completionHandler: {(data, response, error) in
            if let error = error as NSError? {
                if error.code == NSURLErrorCancelled {
                    return
                }
            }
            
            DispatchQueue.main.sync {
                completion(data, response)
            }
        });
        
        task?.resume()
    }
    
    public func executeWithJSON(completion: @escaping (_ data: JSON?, _ response: URLResponse?) -> Void) {
        self.cancelTask()
        
        guard let s = self.session, let req = getRequest() else {
            DispatchQueue.main.sync { completion(nil, nil) }
            return
        }
        
        //print("REQ: \(req.url)")
        
        task = s.dataTask(with:req, completionHandler: {(data, response, error) in
            if let error = error as NSError? {
                if error.code == NSURLErrorCancelled {
                    return
                }
            }
            
            
            if data != nil {
                let resd = String(data: data!, encoding: .utf8)
                //print("RES: \(resd)")
            }
            
            
            if let data = data, let json = PLKJSON.decode(data: data) {
                DispatchQueue.main.sync {
                    completion(json, response)
                }
                return
            }
            
            DispatchQueue.main.sync { completion(nil, response) }
        });
        
        task?.resume()
    }
    
    // -----------
    
    private func getRequest() -> URLRequest? {
        guard let url = self.url else {
            return nil
        }
        
        var request = URLRequest(url: url)
        
        switch (self.method) {
        case .GET:
            request.httpMethod = "get"
        case .POST:
            request.httpMethod = "post"
        case .PUT:
            request.httpMethod = "put"
        case .DELETE:
            request.httpMethod = "delete"
        }
        
        if(_header != nil) {
            for (key, value) in _header! {
                request.addValue(value, forHTTPHeaderField: key)
            }
        }
        
        if(_formData != nil) {
            request.httpBody = queryStringWithParams().data(using: String.Encoding.utf8);
        }
        
        return request
    }
    
    private func queryStringWithParams() -> String {
        let query = NSMutableArray()
        
        for (key, value) in _formData! {
            query.add(key + "=" + value)
        }
        
        return query.componentsJoined(by: "&");
    }
    
    

}
