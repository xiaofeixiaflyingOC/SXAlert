//
//  SXCommon.h
//  SXAlert
//
//  Created by shengxin on 16/6/23.
//  Copyright © 2016年 shengxin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

extern const CGFloat kDefaultPortraitKeyboardHeight;
extern const CGFloat kDefaultLandscapeKeyboardHeight;
extern const CGFloat kDefaultPadPortraitKeyboardHeight;
extern const CGFloat kDefaultPadLandscapeKeyboardHeight;

#define KEYBOARD_HEIGHT                 kDefaultPortraitKeyboardHeight
#define LANDSCAPE_KEYBOARD_HEIGHT       kDefaultLandscapeKeyboardHeight
#define IPAD_KEYBOARD_HEIGHT            kDefaultPadPortraitKeyboardHeight
#define IPAD_LANDSCAPE_KEYBOARD_HEIGHT  kDefaultPadLandscapeKeyboardHeight

#define ApplicationFrame()				ApplicationFrameForOrientation(DeviceOrientation())
#define KeyboardHeight()                KeyboardHeightForOrientation(DeviceOrientation())

#define IS_PAD							IsPad()
#define IS_LANDSCAPE					UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)

BOOL IsPad();

UIDeviceOrientation DeviceOrientation();

CGRect ApplicationFrameForOrientation(UIInterfaceOrientation orientation);

CGFloat KeyboardHeightForOrientation(UIInterfaceOrientation orientation);

BOOL IsKeyboardVisible();

//screen coordinates
//NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
//For iOS 3.0
CGRect KeyboardFrame();

