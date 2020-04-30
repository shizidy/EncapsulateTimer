//
//  MyProxy.m
//  EncapsulateTimer
//
//  Created by wdyzmx on 2020/4/29.
//  Copyright © 2020 wdyzmx. All rights reserved.
//

#import "MyProxy.h"

@interface MyProxy ()
// weak
@property (nonatomic, weak) id target;

@end

@implementation MyProxy

+ (instancetype)proxyWithTarget:(id)target {
    // NSProxy没有init方法
    MyProxy *proxy = [MyProxy alloc];
    proxy.target = target;
    return proxy;
}

// 方法签名
- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    return [self.target methodSignatureForSelector:sel];
}

// 方法调用
- (void)forwardInvocation:(NSInvocation *)invocation {
    [invocation invokeWithTarget:self.target];
}

- (void)dealloc {
    NSLog(@"%s", __func__);
}

@end
