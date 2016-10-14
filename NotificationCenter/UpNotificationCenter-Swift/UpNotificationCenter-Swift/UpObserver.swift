//
//  UpObserver.swift
//  UpNotificationCenter-Swift
//
//  Created by Chauyan Wang on 10/14/16.
//  Copyright © 2016 upshotech. All rights reserved.
//

import UIKit

class UpObserver: NSObject {

    open var obsever:Any? = nil
    open var userObject:Any? = nil
    open var selector:Selector? = nil
    open var notificationName:NSString? = nil
    
    
    open func initObserver(_ observer:Any, selector:Selector, notificationName:NSString?, object:Any?) {
        self.obsever = observer
        self.selector = selector
        self.notificationName = notificationName
        self.userObject = object
    }
}
