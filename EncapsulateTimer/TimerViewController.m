//
//  TimerViewController.m
//  EncapsulateTimer
//
//  Created by wdyzmx on 2020/4/29.
//  Copyright © 2020 wdyzmx. All rights reserved.
//

#import "TimerViewController.h"
#import "MyTimer.h"
#import "MyProxy.h"

@interface TimerViewController ()
// 任务名字（根据任务名称取消任务）
@property (nonatomic, strong) NSString *taskName;
@property (nonatomic, strong) NSString *taskName2;
//@property (nonatomic, strong) dispatch_source_t timer;

@end

@implementation TimerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    if (!self.timer) {
//        // gcd timer不会产生循环引用，因为GCD的timer没有强引用self
//        dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(0, 0));
//        dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1.0f * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
//        dispatch_source_set_event_handler(timer, ^{
//            static int count = 0;
//            NSLog(@"%d", count++);
//        });
//        self.timer = timer;
//        dispatch_resume(timer);
//    }
    
    // target selector timer
    // 注意循环引用问题，所以用proxy代理解决
    self.taskName = [MyTimer executeTaskWithTarget:[MyProxy proxyWithTarget:self] selector:@selector(timerCount:) start:1.0f interval:3.0f repeats:YES async:YES];
    
    // block timer
//    self.taskName2 = [MyTimer executeTask:^{
//        NSLog(@"block timer == %@", [NSThread currentThread]);
//    } start:0.0f interval:2.0f repeats:YES async:YES];
    
}

- (void)timerCount:(id)object {
    NSLog(@"%@", object);
    NSLog(@"target selector timer == %@", [NSThread currentThread]);
}



- (void)dealloc {
    // 取消任务
    [MyTimer cancelTask:self.taskName];
    [MyTimer cancelTask:self.taskName2];
    NSLog(@"%s", __func__);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
