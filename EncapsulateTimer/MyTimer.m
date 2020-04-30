//
//  MyTimer.m
//  EncapsulateTimer
//
//  Created by wdyzmx on 2020/4/30.
//  Copyright © 2020 wdyzmx. All rights reserved.
//

#import "MyTimer.h"


@interface MyTimer ()

@end
// 全局静态变量保存timer
static NSMutableDictionary *timersDic;
// 信号量控制多个异步线程的线程安全
dispatch_semaphore_t semaphore;

@implementation MyTimer

+ (void)initialize {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        timersDic = [NSMutableDictionary dictionary];
        semaphore = dispatch_semaphore_create(1);
    });
}

// target selector
+ (NSString *)executeTaskWithTarget:(id)target
                           selector:(SEL)selector
                              start:(NSTimeInterval)start
                           interval:(NSTimeInterval)interval
                            repeats:(BOOL)repeats
                              async:(BOOL)async {
    if (!target || !selector) {
        return nil;
    }
    return [self executeTask:^{
        if ([target respondsToSelector:selector]) {
            // 消除警告
            #pragma clang diagnostic push
            #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [target performSelector:selector];
            #pragma clang diagnostic pop
        }
    } start:start interval:interval repeats:repeats async:async];
}

// block
+ (NSString *)executeTask:(void (^)(void))block
                    start:(NSTimeInterval)start
                 interval:(NSTimeInterval)interval
                  repeats:(BOOL)repeats
                    async:(BOOL)async {
    if (!block || start < 0 || (interval <= 0 && repeats)) {
        return nil;
    }
    // 创建队列
    dispatch_queue_t queue = async ? dispatch_get_global_queue(0, 0) : dispatch_get_main_queue();
    // 创建timer
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    // 设置timer信息
    dispatch_source_set_timer(timer, dispatch_time(DISPATCH_TIME_NOW, start * NSEC_PER_SEC), interval * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    // 生成timer标识
    NSString *name = [NSString stringWithFormat:@"%zd", timersDic.count];
    // 保存timer到tiersDic，从而达到延长timer生命周期的目的，并且通过key也能方便删除timer
    timersDic[name] = timer;
    dispatch_semaphore_signal(semaphore);
    
    // 设置回调
    dispatch_source_set_event_handler(timer, ^{
        // 调用block
        block();
        // 如果repeats == NO,不重复执行timer,所以将timer从timersDic中移除
        if (!repeats) {
            [self cancelTask:name];
        }
    });
    // 启动timer
    dispatch_resume(timer);
    
    return name;
}

+ (void)cancelTask:(NSString *)name {
    if (name.length == 0) {
        return;
    }
    //dispatch_semaphore_t 控制多线程安全
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    dispatch_source_t timer = timersDic[name];
    if (timer) {
        // 取消timer
        dispatch_source_cancel(timer);
        // 移除timer
        [timersDic removeObjectForKey:name];
    }
    dispatch_semaphore_signal(semaphore);
    
}

- (void)dealloc {
    NSLog(@"%s", __func__);
}


@end
