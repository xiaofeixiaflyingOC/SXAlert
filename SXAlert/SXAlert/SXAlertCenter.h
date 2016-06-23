//
//  SXAlertCenter.h
//  SXAlert
//
//  Created by shengxin on 16/6/23.
//  Copyright © 2016年 shengxin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum {
    SXAlertPositionTop = 0,
    SXAlertPositionCenter,
    SXAlertPositionBottom
} SXAlertPosition;

@class SXAlertView;

@interface SXAlertCenter : NSObject {
    
    NSMutableArray *alerts_;
    SXAlertView *alertView_;
    SXAlertPosition alertPosition_;
    CGFloat padding_;
    BOOL active_;
    CGRect alertFrame_;
}

@property (nonatomic, assign) SXAlertPosition alertPosition;
@property (nonatomic, assign) CGFloat padding;

/** 获取单例 */
+ (SXAlertCenter *)defaultCenter;
/**
 提交一个带图像的消息提示框
 @note 消息提示框的显示以队列形式进行,当前面的提示框全部显示完毕,当前提交的显示框才会显示
 显示时间计算公式: duration = MAX(((double)[words count]*60.0/200.0),1);
 @see postAlertWithMessage:
 */
- (void)postAlertWithMessage:(NSString*)message image:(UIImage*)image;

/** @see postAlertWithMessage:image: */
- (void)postAlertWithMessage:(NSString *)message;

@end
