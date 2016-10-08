# LYAlertView
快速实现自定义alertView

初始化方法<br>

    LYAlertView *alertView = [[LYAlertView alloc] initWithTitle:@"提示" Message:@"是否确认删除" cancelButton:@"取消" confirmButton:@"确认"];
    [alertView show];
    
    // 只有一个button时的操作
    [alertView setCancelBlock:^{
        NSLog(@"取消操作");
    }];
    
    [alertView setConfirmBlock:^{
        NSLog(@"确认操作");
    }];

    // 无信息时置为nil
    LYAlertView *alertView = [[LYAlertView alloc] initWithTitle:@"提示" Message:nil cancelButton:nil confirmButton:@"确认"];
    [alertView show];
    // 只有一个button时的操作
    [alertView setCancelBlock:^{
        NSLog(@"取消操作");
    }];



    
