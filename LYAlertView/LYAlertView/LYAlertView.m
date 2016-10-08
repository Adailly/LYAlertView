//
//  LYAlertView.m
//  弹框
//
//  Created by yang on 16/10/1.
//  Copyright © 2016年 yang. All rights reserved.
//

#import "LYAlertView.h"

#define HEXCOLOR(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define buttonType 100
#define screenWidth [UIScreen mainScreen].bounds.size.width
#define screenHeight [UIScreen mainScreen].bounds.size.height

@interface LYAlertView ()

/** 背景*/
@property (strong, nonatomic) UIView *backView;
/** 显示框背景*/
@property (strong, nonatomic) UIView *alertView;
/** buttonArray*/
@property (strong, nonatomic) NSMutableArray *buttonArray;

@end

@implementation LYAlertView

- (instancetype)initWithTitle:(NSString *)title Message:(NSString *)message cancelButton:(NSString *)cancelBUtton confirmButton:(NSString *)confirmButton
{
    self = [super initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.alpha = 0;
        
        // 按钮信息
        self.buttonArray = [NSMutableArray array];
        if (cancelBUtton) {
            [self.buttonArray addObject:cancelBUtton];
        }
        if (confirmButton) {
            [self.buttonArray addObject:confirmButton];
        }
        // 提示信息
        NSMutableArray *titleArray = [NSMutableArray array];
        if (title) {
            [titleArray addObject:title];
        }
        if (message) {
            [titleArray addObject:message];
        }
        NSInteger count = titleArray.count;
        
        // 背景
        self.backView = [[UIView alloc] initWithFrame:self.bounds];
        self.backView.backgroundColor = [UIColor blackColor];
        self.backView.alpha = 0.2;
        [self addSubview:self.backView];
        
        // 显示框背景
        UIView *alertView = [[UIView alloc] init];
        alertView.frame = CGRectMake(0, 0, screenWidth * 0.6, 45 * (count == 2 ? 3 : 2.5));
        alertView.center = CGPointMake(screenWidth * 0.5, screenHeight * 0.5);
        alertView.backgroundColor = [UIColor whiteColor];
        alertView.layer.cornerRadius = 6;
        alertView.layer.masksToBounds = YES;
        self.alertView = alertView;
        [self addSubview:self.alertView];
        
        for (int i = 0; i < count; i++) {
            UILabel *label = [[UILabel alloc] init];
            label.backgroundColor = [UIColor clearColor];
            label.text = titleArray[i];
            label.numberOfLines = 0;
            label.textAlignment = NSTextAlignmentCenter;
            if (i == 0) {
                label.font = [UIFont boldSystemFontOfSize:17];
            } else {
                label.font = [UIFont systemFontOfSize:15];
            }
            
            if (count == 1) {
                label.frame = CGRectMake(0, 0, self.alertView.frame.size.width, 45 * 1.5);

            } else {
                label.frame = CGRectMake(0, i * 45, self.alertView.frame.size.width, 45);

            }
            [self.alertView addSubview:label];
        }
        UIView *hline = [[UIView alloc] initWithFrame:CGRectMake(0, (count == 2 ? 2 : 1.5) * 45, self.alertView.frame.size.width, 1)];
        hline.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
        [self.alertView addSubview:hline];
        
        CGFloat btnW;
        if (self.buttonArray.count == 2) {
            btnW = self.alertView.frame.size.width / 2;
        }else{
            btnW = self.alertView.frame.size.width;
        }
        for (int i = 0; i < self.buttonArray.count; i++) {
            UIButton *button = [self creatButtonWithTitle:self.buttonArray[i] target:self action:@selector(buttonAction:) type:i];
            button.frame = CGRectMake(i * btnW, CGRectGetMaxY(hline.frame), btnW, 45);
            [self.alertView addSubview:button];
        }
        // 中间分割线
        if (self.buttonArray.count == 2) {
            UIView *vline = [[UIView alloc] initWithFrame:CGRectMake(self.alertView.frame.size.width * 0.5, count * 45, 1, 45)];
            vline.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
            [self.alertView addSubview:vline];
        }
        
    }
    return self;
}

- (void)show
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
    
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 1.0;
        self.alertView.transform = CGAffineTransformMakeScale(1.0, 1.0);
    }];
}

- (void)hideView
{
    [UIView animateWithDuration:0.25 animations:^{
        self.alertView.transform = CGAffineTransformMakeScale(0.6, 0.6);
    } completion:^(BOOL finished) {
        self.alpha = 0.0;

        [self removeFromSuperview];
    }];
}

- (void)buttonAction:(UIButton *)button
{
    [self hideView];
    NSInteger index = button.tag - buttonType;
    if (index == 0) {
        !self.cancelBlock? : self.cancelBlock();
    }
    if (index == 1) {
        !self.confirmBlock? : self.confirmBlock();
    }
}

- (UIButton *)creatButtonWithTitle:(NSString *)title target:(id)target action:(SEL)action type:(NSInteger)type
{
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    button.backgroundColor = [UIColor whiteColor];
    button.tag = buttonType + type;
    [button setTitle:title forState:(UIControlStateNormal)];
    [button setTitle:title forState:(UIControlStateHighlighted)];
    [button setTitleColor:HEXCOLOR(0x69c5f9) forState:(UIControlStateNormal)];
    [button setTitleColor:HEXCOLOR(0x69c5f9) forState:(UIControlStateHighlighted)];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [button addTarget:target action:action forControlEvents:(UIControlEventTouchUpInside)];
    
    return button;
}

@end
