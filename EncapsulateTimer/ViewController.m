//
//  ViewController.m
//  EncapsulateTimer
//
//  Created by wdyzmx on 2020/4/29.
//  Copyright © 2020 wdyzmx. All rights reserved.
//

#import "ViewController.h"
#import "TimerViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    TimerViewController *viewController = [[TimerViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
