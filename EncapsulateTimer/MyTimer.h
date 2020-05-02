//
//  MyTimer.h
//  EncapsulateTimer
//
//  Created by wdyzmx on 2020/4/30.
//  Copyright © 2020 wdyzmx. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyTimer : NSObject
/// timer定时执行task @selector版
/// @param target target
/// @param start 开始时间
/// @param interval 时间间隔
/// @param repeats 是否重复执行
/// @param async 是否异步执行timer
+ (NSString *)executeTaskWithTarget:(id)target
                           selector:(SEL)selector
                              start:(NSTimeInterval)start
                           interval:(NSTimeInterval)interval
                            repeats:(BOOL)repeats
                              async:(BOOL)async;

/// timer定时执行task block回调版
/// @param block timer定时执行的block
/// @param start 开始时间
/// @param interval 时间间隔
/// @param repeats 是否重复执行
/// @param async 是否异步执行timer
+ (NSString *)executeTask:(void(^)(void))block
                    start:(NSTimeInterval)start
                 interval:(NSTimeInterval)interval
                  repeats:(BOOL)repeats
                    async:(BOOL)async;

/// 取消task
/// @param name 任务名称
+(void)cancelTask:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
