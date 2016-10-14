//
//  UpNotificationCenter.m
//  UpNotificationCenter
//
//  Created by Chauyan Wang on 10/14/16.
//  Copyright © 2016 upshotech. All rights reserved.
//

#import "UpNotificationCenter.h"
#import "UpObserver.h"

@implementation UpNotificationCenter
{
    NSMutableArray *observerArray;
}

- (instancetype) init {
    if (self = [super init]) {
        observerArray = [[NSMutableArray alloc] init];
    }
    return self;
}

+ (UpNotificationCenter *)defaultCenter {
    static UpNotificationCenter *defaultCenter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        defaultCenter = [[self alloc] init];
    });

    return defaultCenter;
}

- (void) addObserver:(id)observer selector:(SEL)aSelector name:(NSString *)notificationName object:(id)userObject {
    UpObserver *model = [[UpObserver alloc] init];
    model.observer = observer;
    model.userObject = userObject;
    model.selector = aSelector;
    model.notificationName = notificationName;
    [observerArray addObject:model];
}

- (void) postNotificationName:(NSString *)notificationName object:(id)userObject {
    [observerArray enumerateObjectsUsingBlock:^(UpObserver* obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.notificationName isEqualToString:notificationName]) {
            [obj.observer performSelector:obj.selector withObject:obj.userObject];
        }
    }];
}

- (void) removeObserver:(id)observer {
    __block UpObserver *model;
    [observerArray enumerateObjectsUsingBlock:^(UpObserver* obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.observer isKindOfClass:[observer class]]) {
            model = obj;
        }
    }];
    
    [observerArray removeObject:model];
}
@end
