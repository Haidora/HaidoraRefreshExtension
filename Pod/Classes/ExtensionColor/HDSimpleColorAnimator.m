//
//  HDSimpleColorAnimator.m
//  Pods
//
//  Created by Dailingchi on 15/4/16.
//
//

#import "HDSimpleColorAnimator.h"

#define kSimpleColor_Normal [UIColor colorWithRed:0.196 green:0.604 blue:0.902 alpha:1]
#define kSimpleColor_Realse [UIColor colorWithRed:1.000 green:0.867 blue:0.078 alpha:1]
#define kSimpleColor_Loading [UIColor colorWithRed:0.765 green:0.157 blue:0.133 alpha:1]

@interface HDSimpleColorAnimator ()

@property (nonatomic, strong) UIView *superView;
@property (nonatomic, strong) UIView *contenView;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation HDSimpleColorAnimator

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.normalColor = kSimpleColor_Normal;
        self.triggeredColor = kSimpleColor_Realse;
        self.loadingColor = kSimpleColor_Loading;
    }
    return self;
}

- (UIView *)contenView
{
    if (nil == _contenView)
    {
        _contenView = [[UIView alloc] init];
        _contenView.backgroundColor = self.normalColor;
    }
    return _contenView;
}

- (UILabel *)titleLabel
{
    if (nil == _titleLabel)
    {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (void)startLoadingAnimation
{
    self.titleLabel.text = NSLocalizedStringFromTable(@"Loading...", HDRefreshBundleName, @"");
    [UIView animateWithDuration:0.3
                     animations:^{
                       self.contenView.backgroundColor = self.loadingColor;
                     }];
}

- (void)stopLoadingAnimation
{
    [UIView animateWithDuration:0.3
                     animations:^{
                       self.contenView.backgroundColor = self.normalColor;
                     }];
}

- (void)changeProgress:(CGFloat)progress
{
    UIColor *backColor;
    if (progress > 1)
    {
        self.titleLabel.text =
            NSLocalizedStringFromTable(@"Realse to Refresh...", HDRefreshBundleName, @"");
        backColor = self.triggeredColor;
    }
    else
    {
        self.titleLabel.text =
            NSLocalizedStringFromTable(@"Pull to Refresh...", HDRefreshBundleName, @"");
        backColor = self.normalColor;
    }
    [UIView animateWithDuration:0.3
                     animations:^{
                       self.contenView.backgroundColor = backColor;
                     }];
}

- (void)layoutSubviewsWith:(UIView *)superView
{
    self.superView = superView;
    if (self.contenView.superview == nil)
    {
        CGRect frame = superView.bounds;
        if (_position == HDRefreshViewPositionTop)
        {
            frame.origin.y -= 500;
        }
        frame.size.height += 500;
        self.contenView.frame = frame;
        [superView addSubview:self.contenView];
    }
    if (self.titleLabel.superview == nil)
    {
        self.titleLabel.frame = superView.bounds;
        [superView addSubview:self.titleLabel];
    }
}

@end
