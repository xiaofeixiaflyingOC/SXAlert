//
//  SXLoading.h
//  SXAlert
//
//  Created by shengxin on 16/6/23.
//  Copyright © 2016年 shengxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SXLoading : UIView {
@private
    UIView *backgroundView_;
    UIView *boarderView_;
    UILabel *messageLabel_;
    UIActivityIndicatorView *activityView_;
    
    BOOL isNetWork_;
    BOOL modaled_;
    BOOL showBoarder_;
}

/** 背景View, 非modal 模式下不显示 */
@property (nonatomic, retain) UIView *backgroundView;

/** 边界, 中间的半透明圆角矩形 */
@property (nonatomic, retain) UIView *boarderView;

/** 消息显示容器 */
@property (nonatomic, retain) UILabel *messageLabel;

/** 指示器 */
@property (nonatomic, retain) UIActivityIndicatorView *activityView;

/** 如设置为YES 则状态条将显示网络指示器 */
@property (nonatomic, assign) BOOL isNetWork;

/** 如设置为YES 则superview 在loadingView作用期间无法点击 */
@property (nonatomic, assign) BOOL modaled;

/** 是否显示中间的半透明圆角矩形 */
@property (nonatomic, assign) BOOL showBoarder;

/** 初始化函数.
 @param [in] aMessage 消息框显示内容,建议不要超过20个字符.
 @return 初始化后对象
 @pre alloc
 @code
 ZUILoading *loading = [ZUILoading alloc] initWithMessage:foo];
 @endcode
 */
- (id)initWithMessage:(NSString *)aMessage;

- (void)start;

- (void)stop;


/** 在指定的View中显示
 @see hideWithAnimated:
 */
- (void)showInView:(UIView *)aView modaled:(BOOL)modaled;

/** 隐藏
 @see showInView:modaled:
 */
- (void)hideWithAnimated:(BOOL)animated;

/** 设置显示消息,可以在显示中更改,更改后会自动刷新 */
- (void)setMessage:(NSString *)aMessage;

@end
