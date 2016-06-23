//
//  SXCommon.m
//  SXAlert
//
//  Created by shengxin on 16/6/23.
//  Copyright © 2016年 shengxin. All rights reserved.
//

#import "SXCommon.h"
#import "UIWindow+SXCategory.h"

const CGFloat kDefaultPortraitKeyboardHeight      = 216;
const CGFloat kDefaultLandscapeKeyboardHeight     = 162;
const CGFloat kDefaultPadPortraitKeyboardHeight   = 264;
const CGFloat kDefaultPadLandscapeKeyboardHeight  = 352;

BOOL IsPad() {
#ifdef __IPHONE_3_2
    return UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad;
#else
    return NO;
#endif
}


UIDeviceOrientation DeviceOrientation(){
    UIDeviceOrientation orient = [UIDevice currentDevice].orientation;
    if (UIDeviceOrientationUnknown == orient) {
        return UIDeviceOrientationPortrait;
        
    } else {
        return orient;
    }
}

CGRect ApplicationFrameForOrientation(UIInterfaceOrientation orientation){
    CGRect bounds = [UIScreen mainScreen].bounds ;
    if (UIInterfaceOrientationIsLandscape(orientation)) {
        CGFloat width = bounds.size.width;
        bounds.size.width = bounds.size.height;
        bounds.size.height = width;
    }
    bounds.origin.x = 0;
    bounds.origin.y = 0;
    return bounds;
}

CGFloat KeyboardHeightForOrientation(UIInterfaceOrientation orientation){
    if (IsPad()) {
        return UIInterfaceOrientationIsPortrait(orientation) ? IPAD_KEYBOARD_HEIGHT
        : IPAD_LANDSCAPE_KEYBOARD_HEIGHT;
        
    } else {
        return UIInterfaceOrientationIsPortrait(orientation) ? KEYBOARD_HEIGHT
        : LANDSCAPE_KEYBOARD_HEIGHT;
    }
}

BOOL IsKeyboardVisible() {
    // Operates on the assumption that the keyboard is visible if and only if there is a first
    // responder; i.e. a control responding to key events
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    return !![window findFirstResponder];
}

CGRect KeyboardFrame(){
    UIInterfaceOrientation o = [UIApplication sharedApplication].statusBarOrientation;
    
    CGRect bounds = [[UIScreen mainScreen] bounds];
    CGRect kf = CGRectZero;
    
    switch (o) {
        case UIInterfaceOrientationPortrait:
            kf = CGRectMake(0.0f, bounds.size.height - KeyboardHeight(), bounds.size.width, KeyboardHeight());
            break;
        case UIInterfaceOrientationPortraitUpsideDown:
            kf = CGRectMake(0.0f, 0.0f, bounds.size.width, KeyboardHeight());
            break;
        case UIInterfaceOrientationLandscapeRight:
            kf = CGRectMake(0.0f, 0.0f, KeyboardHeight(), bounds.size.height);
            break;
        case UIInterfaceOrientationLandscapeLeft:
            kf = CGRectMake(bounds.size.width - KeyboardHeight(), 0.0f, KeyboardHeight(), bounds.size.height);
            break;
        default:
            break;
    }
    
    return kf;
}

