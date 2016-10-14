//
//  UpNotificationCenter.swift
//  UpNotificationCenter-Swift
//
//  Created by Chauyan Wang on 10/14/16.
//  Copyright © 2016 upshotech. All rights reserved.
//

import UIKit

open class UpNotificationCenter: NSObject {
    
    let observerArray = NSMutableArray()
    static let selfInstnace = UpNotificationCenter()
    
    open class func defaultCenter() -> UpNotificationCenter {
        return selfInstnace
    }
    
    open func addObserver(_ observer: Any, selector aSelector: Selector, name aName: NSString?, object anObject: Any?) {
        let model = UpObserver()
        model.initObserver(observer, selector: aSelector, notificationName: aName, object: anObject)
        
        observerArray.add(model)
    }
    
    open func post(name aName: NSString, object anObject: Any?) {
        observerArray.enumerateObjects ({ (obj, index, stop) in
            let model = obj as! UpObserver

            if (model.notificationName!.isEqual(to: aName as String)) {
                
                (model.obsever as! NSObject).perform(model.selector, with: model.userObject)
            }
        })
    }
    
    open func removeObserver(_ observer: Any) {
        var model:UpObserver? = nil
        observerArray.enumerateObjects ({ (obj, index, stop) in
            model = obj as? UpObserver
            
            if (model?.obsever as AnyObject === obj as AnyObject) {
                return
            }
        })
        
        if (model != nil) {
            observerArray.remove(model)
        }
    }

}
