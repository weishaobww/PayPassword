//
//  PayPasswordView.m
//  PayPasswordViewDemo
//
//  Created by csj on 2017/10/27.
//  Copyright © 2017年 csj. All rights reserved.
//

#import "PayPasswordView.h"
#import "Constant.h"
#import "PayPasswordInputView.h"
#import "UIView+Category.h"



@interface PayPasswordView()<UITextFieldDelegate>

@property (nonatomic,strong)UIControl   * backControl;  //灰色背景
@property (nonatomic,strong)UITextField * respondTextF;
@property (nonatomic,strong)PayPasswordInputView * payInputView;
@property (nonatomic,copy)  NSString * inputString;

@end


@implementation PayPasswordView

- (PayPasswordInputView *)payInputView {
    if (!_payInputView) {
        _payInputView = [[PayPasswordInputView alloc]init];
        
        __weak typeof(self)weakSelf = self;
        _payInputView.cacelBlock = ^{
            [weakSelf hide];
        };
    }
    return _payInputView;
}

- (UITextField *)respondTextF {
    if (!_respondTextF) {
        _respondTextF = [[UITextField alloc]init];
        _respondTextF.keyboardType = UIKeyboardTypeNumberPad;
        _respondTextF.delegate = self;
        _respondTextF.secureTextEntry = YES;
    }
    return _respondTextF;
}

- (UIControl *)backControl {
    if (!_backControl) {
        _backControl = [[UIControl alloc]init];
        _backControl.frame = self.bounds;
        _backControl.backgroundColor = [UIColor blackColor];
        _backControl.alpha = 0.5;
        [_backControl addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backControl;
}

- (instancetype)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:[[UIScreen mainScreen]bounds]];
    if (self) {

        [self setupUI];
    }
    return self;
}


- (void)setupUI {

    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.backControl];
    [self addSubview:self.respondTextF];
    [self addSubview:self.payInputView];
    
    
}

- (void)drawRect:(CGRect)rect {
    
    
}

- (void)showInView:(UIView *)view {
    
    [view addSubview:self];
    //输入框的起始位置
    self.payInputView.height = kInputViewHeight;
    self.payInputView.y = self.height;
    self.payInputView.width = ScreenWidth;
    self.payInputView.x = 0;
    //弹出键盘
    [self showKeyboard];
    
}

- (void)showKeyboard {
    //键盘响应
    [self.respondTextF becomeFirstResponder];
    
    
    [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
        self.payInputView.y = self.height - self.payInputView.height;
    } completion:^(BOOL finished) {
    }];
}

- (void)hide {
    [self removeFromSuperview];
}

#pragma mark -- UITextFieldDelegate --
#pragma mark  数字 和 删除键
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSLog(@"string = %@",string);
    
    if (!_inputString) {
        _inputString = string;
    } else {
//        _inputString = [NSString stringWithFormat:@"%@%@",_inputString,string];
        _inputString = [_inputString stringByAppendingString:string];
    }
    
    if ([string isEqualToString:@""]) {
        //删除键
        [[NSNotificationCenter defaultCenter]postNotificationName:@"DeleteButtonClickNotification" object:nil];
        if ([self.inputString length] > 0) {
            self.inputString = [self.inputString substringToIndex:self.inputString.length - 1];
        }
        
    }else {
        //数字键
        if (self.inputString.length == kMAXLength) { //数字够了
            
            if (_finishBlock) {
                _finishBlock(self.inputString);
                _finishBlock = nil;
            }
            self.inputString = nil;
        }
        
        //发送点击键盘数字通知
        [[NSNotificationCenter defaultCenter]postNotificationName:@"NumberButtonClickNotification" object:self userInfo:@{@"number":string}];
    }
    return YES;
}

@end
