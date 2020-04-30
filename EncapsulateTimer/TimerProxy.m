//
//  TimerProxy.m
//  EncapsulateTimer
//
//  Created by wdyzmx on 2020/4/29.
//  Copyright © 2020 wdyzmx. All rights reserved.
//

#import "TimerProxy.h"

@interface TimerProxy ()
// weak
@property (nonatomic, weak) id target;

@end

@implementation TimerProxy

+ (instancetype)proxyWithTarget:(id)target {
    TimerProxy *proxy = [[TimerProxy alloc] init];
    proxy.target = target;
    return proxy;
}

#pragma mark - 消息转发
- (id)forwardingTargetForSelector:(SEL)aSelector {
    return self.target;
}

- (void)dealloc {
    NSLog(@"%s", __func__);
}

@end
