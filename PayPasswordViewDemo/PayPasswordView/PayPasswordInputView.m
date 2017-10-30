//
//  PayPasswordInputView.m
//  PayPasswordViewDemo
//
//  Created by csj on 2017/10/27.
//  Copyright © 2017年 csj. All rights reserved.
//

#import "PayPasswordInputView.h"
#import "Constant.h"
#import "UIView+Category.h"

const CGFloat PasswordViewCloseButtonWH = 55;
const CGFloat PasswordViewTitleHeight = 55;
const CGFloat PasswordViewTextFieldMarginTop = 25;
const CGFloat PasswordViewTextFieldWidth = 297;
const CGFloat PasswordViewTextFieldHeight = 50;
const CGFloat PasswordViewPointnWH = 10;


@interface PayPasswordInputView()

@property (nonatomic, strong) UIButton *closeButton; //关闭按钮
@property (nonatomic, strong) NSMutableArray * inputNmberArray; //输入数字集合

@end


@implementation PayPasswordInputView


- (UIButton *)closeButton {
    if (!_closeButton) {
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeButton setTitle:@"取消" forState:UIControlStateNormal];
        [_closeButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_closeButton addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _closeButton;
}

- (NSMutableArray *)inputNmberArray {
    if (!_inputNmberArray) {
        _inputNmberArray = [NSMutableArray array];
    }
    return _inputNmberArray;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setupUI];
        
        [self setupNotification];
    }
    return self;
}

- (void)setupNotification {

    //点击删除按钮
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(deleteNumber:) name:@"DeleteButtonClickNotification" object:nil];
    //点击数字
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyNumber:) name:@"NumberButtonClickNotification" object:nil];
}

- (void)setupUI {
    [self addSubview:self.closeButton];
    
}

//布局
- (void)layoutSubviews {
    [super layoutSubviews];

    self.closeButton.width = PasswordViewCloseButtonWH;
    self.closeButton.height = PasswordViewCloseButtonWH;
    self.closeButton.x = 0;
    self.closeButton.centerY = PasswordViewTitleHeight * 0.5;
    
    
}

//绘制
- (void)drawRect:(CGRect)rect {
   
    //背景图
    UIImage * backImage = [UIImage imageNamed:@"password_background"];
    [backImage drawInRect:rect];

    //输入框
    UIImage * imgTextfield = [UIImage imageNamed:@"password_textfield"];
    CGFloat textfieldY = PasswordViewTitleHeight + PasswordViewTextFieldMarginTop;
    CGFloat textfieldW = PasswordViewTextFieldWidth;
    CGFloat textfieldX = (ScreenWidth - textfieldW) * 0.5;
    CGFloat textfieldH = PasswordViewTextFieldHeight;
    [imgTextfield drawInRect:CGRectMake(textfieldX, textfieldY, textfieldW, textfieldH)];
    
    //标题
    NSString * title = @"请输入支付密码";
    NSDictionary * attrs = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:18]};
    CGSize size = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
    CGFloat titleW = size.width;
    CGFloat titleH = size.height;
    CGFloat titleY = (PasswordViewTitleHeight - titleH) * 0.5;
    CGFloat titleX = (ScreenWidth - titleW) * 0.5;
    
    NSMutableDictionary *attrs1 = [NSMutableDictionary dictionary];
    attrs1[NSFontAttributeName] = [UIFont boldSystemFontOfSize:18];
    attrs1[NSForegroundColorAttributeName] = [UIColor colorWithRed:100.0/255.0 green:100.0/255.0 blue:100.0/255.0 alpha:1.0];
    CGRect titleRect = CGRectMake(titleX, titleY, titleW, titleH);
    [title drawInRect:titleRect withAttributes:attrs1];
    
    //密码点
    UIImage *pointImage = [UIImage imageNamed:@"password_point"];
    CGFloat pointW = PasswordViewPointnWH;
    CGFloat pointH = PasswordViewPointnWH;
    CGFloat pointY =  textfieldY + (textfieldH - pointH) * 0.5;
    //x坐标会变化
    __block CGFloat pointX;

    //一个格子的宽度
    CGFloat cellWidth = textfieldW / kMAXLength;
    CGFloat padding = (cellWidth - pointW) * 0.5;
    [self.inputNmberArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        pointX = textfieldX + idx * pointW + (2 * idx + 1)*padding;
        [pointImage drawInRect:CGRectMake(pointX, pointY, pointW, pointH)];
    }];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mark -- closeAction --
- (void)closeAction {
    
    self.cacelBlock();
    
    [self.inputNmberArray removeAllObjects];
}

- (void)deleteNumber:(NSNotification *)noti {

    [self.inputNmberArray removeLastObject];
    [self setNeedsDisplay];
    NSLog(@"%@",self.inputNmberArray);
}

- (void)keyNumber:(NSNotification *)noti {

    NSDictionary *userInfo = noti.userInfo;
    NSString *numObj = userInfo[@"number"];
    if (self.inputNmberArray.count >= kMAXLength) return;
    [self.inputNmberArray addObject:numObj];
    [self setNeedsDisplay];
    NSLog(@"%@",self.inputNmberArray);

}

@end
