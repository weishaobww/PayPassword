//
//  PayPasswordView.h
//  PayPasswordViewDemo
//
//  Created by csj on 2017/10/27.
//  Copyright © 2017年 csj. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^FinishBlock) (NSString *password);

@interface PayPasswordView : UIView

@property (nonatomic,copy) FinishBlock finishBlock;

/**
弹出密码框
 */
- (void)showInView:(UIView *)view;
/**
 隐藏密码框
 */
- (void)hide;

@end
