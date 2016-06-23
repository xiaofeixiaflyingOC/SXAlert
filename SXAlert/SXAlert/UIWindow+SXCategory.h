//
//  UIWindow+SXCategory.h
//  SXAlert
//
//  Created by shengxin on 16/6/23.
//  Copyright © 2016年 shengxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWindow(UIWindow_SXCategory)

/**
 * Searches the view hierarchy recursively for the first responder, starting with this window.
 */
- (UIView*)findFirstResponder;

/**
 * Searches the view hierarchy recursively for the first responder, starting with topView.
 */
- (UIView*)findFirstResponderInView:(UIView*)topView;

@end
