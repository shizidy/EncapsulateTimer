//
//  TimerProxy.h
//  EncapsulateTimer
//
//  Created by wdyzmx on 2020/4/29.
//  Copyright © 2020 wdyzmx. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TimerProxy : NSObject
/// 类方法，工厂方法，产生类的实例
/// @param target target对象
+ (instancetype)proxyWithTarget:(id)target;

@end

NS_ASSUME_NONNULL_END
