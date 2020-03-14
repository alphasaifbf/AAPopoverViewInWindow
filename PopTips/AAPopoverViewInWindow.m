//
//  AAPopoverViewInWindow.m
//  PopTips
//
//  Created by alpha on 2020/3/14.
//  Copyright © 2020 alpha. All rights reserved.
//

#import "AAPopoverViewInWindow.h"
#import "UIView+AADUtility.h"

#define isIPhoneX ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone && MAX([UIScreen mainScreen].bounds.size.height,[UIScreen mainScreen].bounds.size.width) == 812)
#define isIPhoneXMax ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone && MAX([UIScreen mainScreen].bounds.size.height,[UIScreen mainScreen].bounds.size.width) == 896)
#define  kSafeAreaTopHeight     (isIPhoneX || isIPhoneXMax ? 24.f : 0.f)
#define  kSafeAreaBottomHeight  (isIPhoneX || isIPhoneXMax ? 34.f : 0.f)
#define kDeviceHeight [UIScreen mainScreen].bounds.size.height
#define kDeviceWidth [UIScreen mainScreen].bounds.size.width

@interface AAPopoverViewInWindow()

@property (nonatomic, weak) UIView *arrowView;

@end


@implementation AAPopoverViewInWindow

+ (CGRect)getNormalShowRect {
    CGFloat y = kSafeAreaTopHeight + 64.0;
    return CGRectMake(0.0, y, kDeviceWidth, kDeviceHeight - y);
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI {
    UIWindow *window = UIApplication.sharedApplication.windows[0];
    
    [self setFrame:window.bounds];
    [window addSubview:self];
    
    [self setBackgroundColor:[UIColor clearColor]];

    UIButton *bgBtn = [[UIButton alloc] initWithFrame:self.bounds];
    [self addSubview:bgBtn];
    [bgBtn addTarget:self action:@selector(allEvent:) forControlEvents:UIControlEventTouchDown];
    
    UIView *contentView = [[UIView alloc] init];
    [contentView setBackgroundColor:[UIColor whiteColor]];
    contentView.layer.shadowOpacity = 0.15;
    contentView.layer.shadowColor = [UIColor blackColor].CGColor;
    contentView.layer.shadowRadius = 15;
    contentView.layer.cornerRadius = 5.0;
    contentView.layer.shadowOffset = CGSizeMake(0, 0);//设置偏移量
    [self addSubview:contentView];
    _contentView = contentView;
    
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(50, -5, 14, 5)];
    [imageview setImage:[UIImage imageNamed:@"xiaoshanjiao"]];
    [contentView addSubview:imageview];
    self.arrowView = imageview;
}

- (void)showPopInfullWindow {
    [self showPopInRect:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight)];
}

- (void)showPopInNormalRect {
    [self showPopInRect:[AAPopoverViewInWindow getNormalShowRect]];
}

- (void)showPopInRect:(CGRect)showRect {
    CGRect sourceViewInWindowFrame = [self.sourceView convertRect:self.sourceView.bounds toView:nil];
    CGFloat interval = 10.0;
    
    CGFloat x = sourceViewInWindowFrame.origin.x + sourceViewInWindowFrame.size.width / 2.0;
    CGFloat y = sourceViewInWindowFrame.origin.y + sourceViewInWindowFrame.size.height / 2.0;
    
    // 判断是否需要调整方向
    AAPopTipsViewArrowDirection arrowDirection = self.arrowDirection;
    switch (arrowDirection) {
            case  AAPopTipsViewArrowDirectionUp:
            {
                if (sourceViewInWindowFrame.origin.y + sourceViewInWindowFrame.size.height + self.contentView.height + interval > showRect.size.height) {
                    //  AAPopTipsViewArrowDirectionUp放不下，需要转 AAPopTipsViewArrowDirectionDown
                    arrowDirection =  AAPopTipsViewArrowDirectionDown;
                }
                break;
            }
            case  AAPopTipsViewArrowDirectionDown:
            {
                if (self.contentView.height + interval > sourceViewInWindowFrame.origin.y) {
                    //  AAPopTipsViewArrowDirectionDown放不下，需要转 AAPopTipsViewArrowDirectionUp
                    arrowDirection =  AAPopTipsViewArrowDirectionUp;
                }
                break;
            }
            case  AAPopTipsViewArrowDirectionLeft:
            {
                if (sourceViewInWindowFrame.origin.x + sourceViewInWindowFrame.size.width + self.contentView.width + interval > showRect.size.width) {
                    //  AAPopTipsViewArrowDirectionLeft放不下，需要转 AAPopTipsViewArrowDirectionRight
                    arrowDirection =  AAPopTipsViewArrowDirectionRight;
                }
                break;
            }
            case  AAPopTipsViewArrowDirectionRight:
            {
                if (self.contentView.width + interval > sourceViewInWindowFrame.origin.x) {
                    //  AAPopTipsViewArrowDirectionRight放不下，需要转 AAPopTipsViewArrowDirectionLeft
                    arrowDirection =  AAPopTipsViewArrowDirectionLeft;
                }
                break;
            }
        default:
            break;
    }
    
    // 根据箭头的位置先，先调整content的位置
    CGPoint point = CGPointMake(0.0, 0.0);
    switch (arrowDirection) {
            case  AAPopTipsViewArrowDirectionUp:
            {
                point = CGPointMake(x, y + self.contentView.height / 2.0 + interval + sourceViewInWindowFrame.size.height / 2.0);
                break;
            }
            case  AAPopTipsViewArrowDirectionDown:
            {
                point = CGPointMake(x, y - self.contentView.height / 2.0 - interval - sourceViewInWindowFrame.size.height / 2.0);
                break;
            }
            case  AAPopTipsViewArrowDirectionLeft:
            {
                point = CGPointMake(x + self.contentView.width / 2.0 + interval + sourceViewInWindowFrame.size.width / 2.0 , y);
                break;
            }
            case  AAPopTipsViewArrowDirectionRight:
            {
                point = CGPointMake(x - self.contentView.width / 2.0 - interval - sourceViewInWindowFrame.size.width / 2.0 , y);
                break;
            }
        default:
            break;
    }
    self.contentView.center = point;
    
    // 把显示内容放到显示区域，调整x轴位置
    if (self.contentView.left < showRect.origin.x) {
        self.contentView.left = showRect.origin.x + interval;
    }
    if (self.contentView.right > showRect.origin.x + showRect.size.width) {
        self.contentView.right = showRect.origin.x + showRect.size.width - interval;
    }

    // 把显示内容放到显示区域，调整y轴位置
    if (self.contentView.top < showRect.origin.y) {
        self.contentView.top = showRect.origin.y + interval;
    }
    if (self.contentView.bottom > showRect.origin.y + showRect.size.height) {
        self.contentView.bottom = showRect.origin.y + showRect.size.height - interval;
    }
    
    // 调整箭头
    if (arrowDirection ==  AAPopTipsViewArrowDirectionUp || arrowDirection ==  AAPopTipsViewArrowDirectionDown) {
        if (self.contentView.bottom < sourceViewInWindowFrame.origin.y) {
            // 提示在上方
            self.arrowView.top = self.contentView.height;
            [self.arrowView setTransform:CGAffineTransformMakeRotation(M_PI)];
        } else {
            // 提示在下方
            self.arrowView.bottom = 0.0;
            [self.arrowView setTransform:CGAffineTransformMakeRotation(0)];
        }
        // 调整箭头的x轴
        self.arrowView.centerX = point.x - self.contentView.left;
    }
    
    // 箭头是左或者右
    if (arrowDirection ==  AAPopTipsViewArrowDirectionLeft || arrowDirection ==  AAPopTipsViewArrowDirectionRight) {
        if (self.contentView.right < sourceViewInWindowFrame.origin.x) {
            // 提示在左方
            self.arrowView.left = self.contentView.width - (self.arrowView.width - self.arrowView.height) / 2.0;
            [self.arrowView setTransform:CGAffineTransformMakeRotation(M_PI / 2)];
        } else {
            // 提示在右方
            self.arrowView.right = 0.0 + (self.arrowView.width - self.arrowView.height) / 2.0;
            [self.arrowView setTransform:CGAffineTransformMakeRotation(-M_PI / 2)];
        }
        // 调整箭头的x轴
        self.arrowView.centerY = point.y - self.contentView.top;
    }
    
    self.alpha = 0;
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1;
    }];
}

- (void)closePop {
    self.alpha = 1;
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)allEvent:(UIButton *)aBtn {
    [self closePop];
}

#pragma mark -getting and setting
- (CGSize)contentViewSize {
   return self.contentView.size;
}

- (void)setContentViewSize:(CGSize)contentViewSize {
    [self.contentView setSize:contentViewSize];
}

- (void)setIsClickContentAutoHidden:(BOOL)isClickContentAutoHidden {
    self.contentView.userInteractionEnabled = !isClickContentAutoHidden;
}

@end
