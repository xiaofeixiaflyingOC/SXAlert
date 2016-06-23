//
//  SXAlertCenter.m
//  SXAlert
//
//  Created by shengxin on 16/6/23.
//  Copyright © 2016年 shengxin. All rights reserved.
//

#import "SXAlertCenter.h"
#import "SXAlertView.h"
#import "UIView+SXCategory.h"
#import "SXCommon.h"

@interface SXAlertCenter()

@property (nonatomic, retain) NSMutableArray *alerts;

- (void)showAlerts;
- (void)animationStep2;
- (void)fitForKeyBoard;
- (void)autoFitForKeyBoard;

@end

@implementation SXAlertCenter

- (id)init{
    if (!(self=[super init])) return nil;
    
    self.alerts = [NSMutableArray array];
    alertView_ = [[SXAlertView alloc] init];
    active_ = NO;
    
    alertFrame_ = [UIApplication sharedApplication].keyWindow.bounds;

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(orientationWillChange:)
                                                 name:UIApplicationWillChangeStatusBarOrientationNotification
                                               object:nil];
    
    return self;
}

#pragma mark -
#pragma mark notification
CGRect subtractRect(CGRect wf,CGRect kf){
    if(!CGPointEqualToPoint(CGPointZero,kf.origin)){
        if(kf.origin.x>0) kf.size.width = kf.origin.x;
        if(kf.origin.y>0) kf.size.height = kf.origin.y;
        kf.origin = CGPointZero;
    }else{
        kf.origin.x = fabs(kf.size.width - wf.size.width);
        kf.origin.y = fabs(kf.size.height -  wf.size.height);
        
        if(kf.origin.x > 0){
            CGFloat temp = kf.origin.x;
            kf.origin.x = kf.size.width;
            kf.size.width = temp;
        }else if (kf.origin.y > 0){
            CGFloat temp = kf.origin.y;
            kf.origin.y = kf.size.height;
            kf.size.height = temp;
        }
        
    }
    
    return CGRectIntersection(wf, kf);
}

- (void) keyboardWillAppear:(NSNotification *)notification{
    [UIView beginAnimations:nil context:nil];
    [self fitForKeyBoard];
    [UIView commitAnimations];
}

- (void) keyboardWillDisappear:(NSNotification *) notification{
    alertFrame_ = [UIApplication sharedApplication].keyWindow.bounds;
}

- (void) orientationWillChange:(NSNotification *) notification{
    NSDictionary *userInfo = [notification userInfo];
    NSNumber *v = [userInfo objectForKey:UIApplicationStatusBarOrientationUserInfoKey];
    UIInterfaceOrientation o = [v intValue];
    
    
    CGFloat degrees = 0;
    if(o == UIInterfaceOrientationLandscapeLeft ) degrees = -90;
    else if(o == UIInterfaceOrientationLandscapeRight) degrees = 90;
    else if(o == UIInterfaceOrientationPortraitUpsideDown) degrees = 180;
    
    [UIView beginAnimations:nil context:nil];
    alertView_.transform = CGAffineTransformMakeRotation(degrees * M_PI / 180);
    alertView_.frame = CGRectMake((int)alertView_.top,
                                  (int)alertView_.left,
                                  (int)alertView_.width,
                                  (int)alertView_.height);
    [UIView commitAnimations];
    
}

#pragma mark -
#pragma mark PublicMethods
- (void) postAlertWithMessage:(NSString*)message image:(UIImage*)image
{
    [self.alerts addObject:[NSArray arrayWithObjects:message,image,nil]];
    if(!active_) [self showAlerts];
}

- (void) postAlertWithMessage:(NSString*)message
{
    [self postAlertWithMessage:message image:nil];
}

#pragma mark -
#pragma mark PrivateMethods
+ (SXAlertCenter *)defaultCenter{
    static SXAlertCenter *defaultCenter = nil;
    if (!defaultCenter) {
        defaultCenter = [[SXAlertCenter alloc] init];
        defaultCenter.alertPosition = SXAlertPositionCenter;
        defaultCenter.padding = 10.0f;
    }
    return defaultCenter;
}

- (void)showAlerts{

    if([self.alerts count] < 1) {
        active_ = NO;
        return;
    }    
    active_ = YES;
    
    alertView_.transform = CGAffineTransformIdentity;
    alertView_.alpha = 0;
    [[UIApplication sharedApplication].keyWindow addSubview:alertView_];
    
    
    NSArray *ar = [self.alerts objectAtIndex:0];
    
    UIImage *img = nil;
    if([ar count] > 1) img = [ar objectAtIndex:1];
    
    [alertView_ setImage:img];
    
    if([ar count] > 0) [alertView_ setMessageText:[ar objectAtIndex:0]];
    
    
    [self autoFitForKeyBoard];
    
    switch (self.alertPosition) {
        case SXAlertPositionTop:
            alertView_.center = CGPointMake(alertFrame_.origin.x + alertFrame_.size.width / 2,
                                            alertFrame_.origin.y + padding_ + alertView_.height / 2);
            break;
        case SXAlertPositionCenter:
            alertView_.center = CGPointMake(alertFrame_.origin.x + alertFrame_.size.width / 2,
                                            alertFrame_.origin.y + alertFrame_.size.height / 2);
            break;
        case SXAlertPositionBottom:
            alertView_.center = CGPointMake(alertFrame_.origin.x + alertFrame_.size.width / 2,
                                            alertFrame_.origin.y + alertFrame_.size.height - alertView_.height / 2 - padding_);
            break;
        default:
            break;
    }

    CGRect rr = alertView_.frame;
    rr.origin.x = (int)rr.origin.x;
    rr.origin.y = (int)rr.origin.y;
    alertView_.frame = rr;
    
    UIInterfaceOrientation o = [UIApplication sharedApplication].statusBarOrientation;
    CGFloat degrees = 0;
    if(o == UIInterfaceOrientationLandscapeLeft ) degrees = -90;
    else if(o == UIInterfaceOrientationLandscapeRight ) degrees = 90;
    else if(o == UIInterfaceOrientationPortraitUpsideDown) degrees = 180;
    alertView_.transform = CGAffineTransformMakeRotation(degrees * M_PI / 180);
    alertView_.transform = CGAffineTransformScale(alertView_.transform, 2, 2);
    
    
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.15];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationStep2)];
    
    alertView_.transform = CGAffineTransformMakeRotation(degrees * M_PI / 180);
    alertView_.frame = CGRectMake((int)alertView_.left,
                                  (int)alertView_.top,
                                  alertView_.width,
                                  alertView_.height);
    alertView_.alpha = 1;
    
    [UIView commitAnimations];
}

- (void) animationStep2{
    [UIView beginAnimations:nil context:nil];
    
    // depending on how many words are in the text
    // change the animation duration accordingly
    // avg person reads 200 words per minute
    //	NSArray * words = [[[self.alerts objectAtIndex:0] objectAtIndex:0] componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    //	double duration = MAX(((double)[words count]*60.0/200.0),1);
    double duration = MAX(((double)[alertView_.messageText length]/3 * 60/200), 1);
    [UIView setAnimationDelay:duration];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationStep3)];
    
    UIInterfaceOrientation o = [UIApplication sharedApplication].statusBarOrientation;
    CGFloat degrees = 0;
    if(o == UIInterfaceOrientationLandscapeLeft) degrees = -90;
    else if(o == UIInterfaceOrientationLandscapeRight) degrees = 90;
    else if(o == UIInterfaceOrientationPortraitUpsideDown) degrees = 180;
    alertView_.transform = CGAffineTransformMakeRotation(degrees * M_PI / 180);
    alertView_.transform = CGAffineTransformScale(alertView_.transform, 0.5, 0.5);
				
    alertView_.alpha = 0;
    [UIView commitAnimations];
}

- (void) animationStep3
{
    [alertView_ removeFromSuperview];
    [self.alerts removeObjectAtIndex:0];
    NSLog(@"%@",self.alerts);
    [self showAlerts];
}

- (void)fitForKeyBoard
{
    CGRect kf = KeyboardFrame();
    
    CGRect wf = [UIApplication sharedApplication].keyWindow.bounds;
    
    alertFrame_ = subtractRect(wf,kf);
    alertView_.center = CGPointMake(alertFrame_.origin.x + alertFrame_.size.width / 2, 
                                    alertFrame_.origin.y + alertFrame_.size.height / 2);
}

- (void)autoFitForKeyBoard
{
    if (IsKeyboardVisible()) {
        CGRect kf = KeyboardFrame();
        
        CGRect wf = [UIApplication sharedApplication].keyWindow.bounds;
        
        alertFrame_ = subtractRect(wf,kf);
    } else {
        alertFrame_ = [UIApplication sharedApplication].keyWindow.bounds;
    }
    
}


@end

