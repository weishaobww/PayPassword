//
//  ViewController.m
//  PayPasswordViewDemo
//
//  Created by csj on 2017/10/27.
//  Copyright © 2017年 csj. All rights reserved.
//

#import "ViewController.h"
#import "PayPasswordView.h"
#import "Constant.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //取消
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(cacelNotif:) name:PasswordViewCancleButtonClickNotification object:nil];
}

//- (void)cacelNotif:(NSNotification *)noti {
//
//}

- (IBAction)confirmPay:(id)sender {
   
    PayPasswordView * payView = [[PayPasswordView alloc]init];
    [payView showInView:self.view.window];
    
    __weak typeof(payView)weakPayView = payView;
    __weak typeof(self)weakSelf = self;
    
    payView.finishBlock = ^(NSString *password) {
        //移除
        [weakPayView hide];
        
        //这边可以做请求数据
        
        NSString * text = [NSString stringWithFormat:@"密码是：%@",password];
        NSLog(@"%@",text);
        
        UIAlertController * alertC = [UIAlertController alertControllerWithTitle:@"输入密码" message:text preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
        [alertC addAction:okAction];
        [weakSelf presentViewController:alertC animated:YES completion:nil];
        
    };
    
}

//- (void)dealloc {
//    [[NSNotificationCenter defaultCenter]removeObserver:self];
//}
@end
