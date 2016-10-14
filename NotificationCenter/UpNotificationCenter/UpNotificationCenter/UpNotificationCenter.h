//
//  UpNotificationCenter.h
//  UpNotificationCenter
//
//  Created by Chauyan Wang on 10/14/16.
//  Copyright © 2016 upshotech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UpNotificationCenter : NSObject

+ (UpNotificationCenter *)defaultCenter;
- (void) addObserver:(id)observer selector:(SEL) aSelector name: (NSString *) notificationName object:(id)userObject;
- (void) postNotificationName:(NSString *) notificationName object:(id)userObject;
- (void) removeObserver:(id) observer;

@end
