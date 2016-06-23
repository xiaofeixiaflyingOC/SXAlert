//
//  SXAlertView.h
//  SXAlert
//
//  Created by shengxin on 16/6/23.
//  Copyright © 2016年 shengxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SXAlertView : UIView

@property (nonatomic, copy) NSString *messageText;

- (id)init;
- (void)setMessageText:(NSString*)str;
- (void)setImage:(UIImage*)image;

@end
