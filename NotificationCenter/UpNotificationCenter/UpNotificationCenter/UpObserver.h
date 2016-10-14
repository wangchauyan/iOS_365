//
//  UpObserver.h
//  UpNotificationCenter
//
//  Created by Chauyan Wang on 10/14/16.
//  Copyright © 2016 upshotech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UpObserver : NSObject

@property (nonatomic, strong) id observer;
@property (nonatomic, strong) id userObject;
@property (nonatomic, assign) SEL selector;
@property (nonatomic, strong) NSString *notificationName;
@end
