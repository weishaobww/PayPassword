//
//  PayPasswordInputView.h
//  PayPasswordViewDemo
//
//  Created by csj on 2017/10/27.
//  Copyright © 2017年 csj. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef  void (^CacelBlock)();

@interface PayPasswordInputView : UIView

@property (nonatomic,copy) CacelBlock cacelBlock;

@end
