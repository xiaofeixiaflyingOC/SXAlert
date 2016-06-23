//
//  SXAlertView.m
//  SXAlert
//
//  Created by shengxin on 16/6/23.
//  Copyright © 2016年 shengxin. All rights reserved.
//

#import "SXAlertView.h"
#import "UIView+SXCategory.h"

@interface SXAlertView()
{
    CGRect	messageRect_;
    NSString *messageText_;
    UIImage *image_;
}

- (void)adjust;

@end

@implementation SXAlertView
- (id)init{
    if (!(self = [super initWithFrame:CGRectMake(0, 0, 100, 100)])) return nil;
    
    messageRect_ = CGRectInset(self.bounds, 10, 10);
    self.backgroundColor = [UIColor clearColor];
    
    return self;
    
}

- (void)drawRect:(CGRect)rect{
    [UIView drawRoundRectangleInRect:rect withRadius:10 color:[UIColor colorWithWhite:0 alpha:0.8]];
    [[UIColor whiteColor] set];

    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.alignment = NSTextAlignmentCenter;
    [messageText_ drawInRect:messageRect_  withAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:14.0],NSParagraphStyleAttributeName:paragraph,NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    CGRect r = CGRectZero;
    r.origin.y = 15;
    r.origin.x = (rect.size.width - image_.size.width) / 2;
    r.size = image_.size;
    
    [image_ drawInRect:r];
}

#pragma mark -
#pragma mark PrivateMethods
- (void)adjust{
  CGRect r = [messageText_ boundingRectWithSize:CGSizeMake(160, 200) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:14.0]} context:nil];
    CGSize s = r.size;
    
    float imageAdjustment = 0;
    if (image_) {
        imageAdjustment = 7 + image_.size.height;
    }
    
    self.bounds = CGRectMake(0, 0, s.width + 40, s.height + 15 + 15 + imageAdjustment);
    
    messageRect_.size = s;
    messageRect_.size.height += 5;
    messageRect_.origin.x = 20;
    messageRect_.origin.y = 15 + imageAdjustment;
    
    [self setNeedsLayout];
    
    // TODO: Fix It
    [self setNeedsDisplay];
}

#pragma mark -
#pragma mark PublicMethods
- (void)setMessageText:(NSString*)str{
    messageText_ = str;
    [self adjust];
}

- (void)setImage:(UIImage*)img{
    image_ = img;
    [self adjust];
}

@end
