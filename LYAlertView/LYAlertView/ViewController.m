//
//  ViewController.m
//  LYAlertView
//
//  Created by yang on 16/10/8.
//  Copyright © 2016年 yang. All rights reserved.
//

#import "ViewController.h"
#import "LYAlertView.h"

@interface ViewController ()

- (IBAction)ShowAlertView:(UIButton *)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)ShowAlertView:(UIButton *)sender
{
    LYAlertView *alertView = [[LYAlertView alloc] initWithTitle:@"提示" Message:@"是否确认删除" cancelButton:@"取消" confirmButton:@"确认"];
    
    // 无信息时置为nil
//    LYAlertView *alertView = [[LYAlertView alloc] initWithTitle:@"提示" Message:nil cancelButton:nil confirmButton:@"确认"];
    [alertView show];
    
    // 只有一个button时的操作
    [alertView setCancelBlock:^{
        NSLog(@"取消操作");
    }];
    
    [alertView setConfirmBlock:^{
        NSLog(@"确认操作");
    }];
}

@end
