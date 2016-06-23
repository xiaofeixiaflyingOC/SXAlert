//
//  SXLoading.m
//  SXAlert
//
//  Created by shengxin on 16/6/23.
//  Copyright © 2016年 shengxin. All rights reserved.
//

#import "SXLoading.h"
#import "UIView+SXCategory.h"

#define kWidthMargin 20
#define kHeightMargin 20
#define kDefaultHeight 200
#define kDefaultWidth 200

@implementation SXLoading

- (id)initWithMessage:(NSString *)aMessage{
    self = [super initWithFrame:CGRectMake(0, 0, kDefaultWidth, kDefaultHeight)];
    if (self) {
        self.autoresizingMask = (UIViewAutoresizingFlexibleWidth
                                 | UIViewAutoresizingFlexibleHeight);
        self.backgroundColor = [UIColor clearColor];
        
        backgroundView_ = [[UIView alloc] initWithFrame:self.bounds];
        backgroundView_.backgroundColor = [UIColor blackColor];
        backgroundView_.alpha = 0.2;
        backgroundView_.autoresizingMask = (UIViewAutoresizingFlexibleWidth
                                            | UIViewAutoresizingFlexibleHeight);
        [self addSubview:backgroundView_];
        
        boarderView_ = [[UIView alloc] initWithFrame:self.bounds];
        boarderView_.backgroundColor = [UIColor clearColor];
        [self addSubview:boarderView_];
        
        activityView_ = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:
                         UIActivityIndicatorViewStyleWhiteLarge];
        [boarderView_ addSubview:activityView_];
        
        messageLabel_ = [[UILabel alloc] init];
        messageLabel_.text = aMessage;
        messageLabel_.lineBreakMode = NSLineBreakByTruncatingTail;
        messageLabel_.numberOfLines = 0;
        messageLabel_.backgroundColor = [UIColor clearColor];
        messageLabel_.textAlignment =  NSTextAlignmentCenter;
        messageLabel_.textColor = [UIColor whiteColor];
        messageLabel_.font = [UIFont systemFontOfSize:16];
        [boarderView_ addSubview:messageLabel_];
    }
    return self;
}

#pragma mark -
#pragma mark UIView
- (void)layoutSubviews{
    [super layoutSubviews];
    if (self.superview) {
        CGRect messageFrame = CGRectZero;
        CGRect boarderFrame = CGRectZero;
//        messageFrame.size = [self sizeWithText:messageLabel_.text
//                                          font:messageLabel_.font
//                                         width:kDefaultWidth
//                                     linebreak:messageLabel_.lineBreakMode];
        
        CGRect rect = [messageLabel_.text boundingRectWithSize:[UIScreen mainScreen].bounds.size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:14.0]} context:nil];
        messageFrame.size = rect.size;
        
        messageFrame.origin = CGPointMake(kWidthMargin, kHeightMargin + activityView_.height + 10);
        messageLabel_.frame = messageFrame;
        boarderFrame.size.height = activityView_.height + messageLabel_.height + kHeightMargin * 2;
        boarderFrame.size.width = (activityView_.width > messageLabel_.width
                                   ? activityView_.width : messageLabel_.width);
        boarderFrame.size.width += 2 *kWidthMargin;
        boarderView_.frame = boarderFrame;
        activityView_.center = CGPointMake(boarderView_.width / 2,
                                           kHeightMargin + activityView_.height / 2);
        boarderView_.center = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
    }
}

- (void)drawRect:(CGRect)rect{
    if (!self.superview) return;
    
    if (showBoarder_) {
        [UIView drawRoundRectangleInRect:boarderView_.frame
                              withRadius:10.0
                                   color:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.75]];
    }
}

#pragma mark -
#pragma mark Accessor
- (void)setIsNetWork:(BOOL)value{
    isNetWork_ = value;
    [self setNeedsLayout];
}

- (void)setModaled:(BOOL)value{
    backgroundView_.hidden = !value;
}

- (void)setActivityView:(UIActivityIndicatorView *)actView{
    activityView_ = actView;
    [self addSubview:activityView_];
    [self setNeedsLayout];
}

- (void)setMessage:(NSString *)aMessage{
    messageLabel_.text = aMessage;
    [self setNeedsLayout];
}

- (void)setShowBoarder:(BOOL)value{
    showBoarder_ = value;
    [self setNeedsDisplay];
}

#pragma mark -
#pragma mark PublicMethods
- (void)start{
    [activityView_ startAnimating];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = isNetWork_;
    [self setHidden:NO];
}

- (void)stop{
    [activityView_ stopAnimating];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [self setHidden:YES];
}

- (void)showInView:(UIView *)aView modaled:(BOOL)modaled{
    [aView addSubview:self];
    self.frame = aView.bounds;
    [self setModaled:modaled];
    [self start];
    
    [self setNeedsLayout];
}

- (void)hideWithAnimated:(BOOL)animated;{
    [self stop];
    [self removeFromSuperview];
}

@end
