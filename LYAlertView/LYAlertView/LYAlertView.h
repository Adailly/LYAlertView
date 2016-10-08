//
//  LYAlertView.h
//  弹框
//
//  Created by yang on 16/10/1.
//  Copyright © 2016年 yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYAlertView : UIView

/** 取消操作或只有一个button时的操作*/
@property (copy, nonatomic) void (^cancelBlock)();

/** 确认操作*/
@property (copy, nonatomic) void (^confirmBlock)();

- (instancetype)initWithTitle:(NSString *)title Message:(NSString *)message cancelButton:(NSString *)cancelBUtton confirmButton:(NSString *)confirmButton;

- (void)show;

@end
