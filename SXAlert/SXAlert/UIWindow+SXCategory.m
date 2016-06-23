//
//  UIWindow+SXCategory.m
//  SXAlert
//
//  Created by shengxin on 16/6/23.
//  Copyright © 2016年 shengxin. All rights reserved.
//

#import "UIWindow+SXCategory.h"

@implementation UIWindow(UIWindow_SXCategory)

- (UIView*)findFirstResponder {
    return [self findFirstResponderInView:self];
}

- (UIView*)findFirstResponderInView:(UIView*)topView {
    if ([topView isFirstResponder]) {
        return topView;
    }
    
    for (UIView* subView in topView.subviews) {
        if ([subView isFirstResponder]) {
            return subView;
        }
        
        UIView* firstResponderCheck = [self findFirstResponderInView:subView];
        if (nil != firstResponderCheck) {
            return firstResponderCheck;
        }
    }
    return nil;
}

@end
