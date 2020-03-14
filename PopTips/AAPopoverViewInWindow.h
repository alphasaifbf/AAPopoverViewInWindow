//
//  AAPopoverViewInWindow.h
//  PopTips
//
//  Created by alpha on 2020/3/14.
//  Copyright © 2020 alpha. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSUInteger, AAPopTipsViewArrowDirection) {
    AAPopTipsViewArrowDirectionUp = 0,
    AAPopTipsViewArrowDirectionDown = 1,
    AAPopTipsViewArrowDirectionLeft = 2,
    AAPopTipsViewArrowDirectionRight = 3,
};

@interface AAPopoverViewInWindow : UIView

/*
 * 需要显示指示的view
 */
@property (nonatomic, weak) UIView *sourceView;

/*
* 箭头方向（默认是AAPopTipsViewArrowDirectionUp）
*/
@property (nonatomic, assign) AAPopTipsViewArrowDirection arrowDirection;

/*
* 提示的内容，只读，可以调整大小，可以把需要提示的内容（image，label等）放到contentView
*/
@property (nonatomic, weak, readonly) UIView *contentView;

/*
* 提示的内容的大小
*/
@property (nonatomic, assign) CGSize contentViewSize;

/*
* 触摸显示区域示范自动隐藏，默认是NO(单纯做提示是，可以设置为YES，如果需要交互，需要设置为NO)
*/
@property (nonatomic, assign) BOOL isClickContentAutoHidden;

/*
* 返回一个去除导航栏的区域
*/
+ (CGRect)getNormalShowRect;

/*
* 在全屏区域显示提示
*/
- (void)showPopInfullWindow;

/*
* 在去除导航栏的区域显示提示
*/
- (void)showPopInNormalRect;

/*
* 在指定的区域显示提示
*/
- (void)showPopInRect:(CGRect)showRect;

/*
* 隐藏提示
*/
- (void)closePop;

@end
