//
//  HDIndicatorAnimator.m
//  HaidoraRefreshExtension
//
//  Created by Dailingchi on 15/5/6.
//  Copyright (c) 2015年 mrdaios. All rights reserved.
//

#import "HDIndicatorAnimator.h"
#define STROKE_ANIMATION @"stroke_animation"
#define ROTATE_ANIMATION @"rotate_animation"

@interface HDIndicatorAnimator ()
{
    NSInteger _colorIndex;
}

@property (nonatomic, strong) UIView *view;
@property (nonatomic, strong) UIView *container;
@property (nonatomic, strong) CAShapeLayer *pathLayer;

@end

@implementation HDIndicatorAnimator

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _colorIndex = 0;
        _colors = @[ [UIColor redColor], [UIColor greenColor], [UIColor blueColor] ];
    }
    return self;
}

- (void)startLoadingAnimation
{
    float currentAngle =
        [(NSNumber *)[_container.layer valueForKeyPath:@"transform.rotation.z"] floatValue];
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"transform.rotation";
    animation.duration = 4.f;
    animation.fromValue = @(currentAngle);
    animation.toValue = @(2 * M_PI + currentAngle);
    animation.repeatCount = INFINITY;
    [_container.layer addAnimation:animation forKey:ROTATE_ANIMATION];

    CABasicAnimation *beginHeadAnimation = [CABasicAnimation animation];
    beginHeadAnimation.keyPath = @"strokeStart";
    beginHeadAnimation.duration = .5f;
    beginHeadAnimation.fromValue = @(.25f);
    beginHeadAnimation.toValue = @(1.f);
    beginHeadAnimation.timingFunction =
        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];

    CABasicAnimation *beginTailAnimation = [CABasicAnimation animation];
    beginTailAnimation.keyPath = @"strokeEnd";
    beginTailAnimation.duration = .5f;
    beginTailAnimation.fromValue = @(1.f);
    beginTailAnimation.toValue = @(1.f);
    beginTailAnimation.timingFunction =
        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];

    CABasicAnimation *endHeadAnimation = [CABasicAnimation animation];
    endHeadAnimation.keyPath = @"strokeStart";
    endHeadAnimation.beginTime = .5f;
    endHeadAnimation.duration = 1.f;
    endHeadAnimation.fromValue = @(.0f);
    endHeadAnimation.toValue = @(.25f);
    endHeadAnimation.timingFunction =
        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];

    CABasicAnimation *endTailAnimation = [CABasicAnimation animation];
    endTailAnimation.keyPath = @"strokeEnd";
    endTailAnimation.beginTime = .5f;
    endTailAnimation.duration = 1.f;
    endTailAnimation.fromValue = @(0.f);
    endTailAnimation.toValue = @(1.f);
    endTailAnimation.timingFunction =
        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];

    CAAnimationGroup *animations = [CAAnimationGroup animation];
    [animations setDuration:1.5f];
    [animations setRemovedOnCompletion:NO];
    [animations
        setAnimations:
            @[ beginHeadAnimation, beginTailAnimation, endHeadAnimation, endTailAnimation ]];
    animations.repeatCount = INFINITY;
    [_pathLayer addAnimation:animations forKey:STROKE_ANIMATION];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC), dispatch_get_main_queue(),
                   ^{
                     [self changeColor];
                   });
}

- (void)stopLoadingAnimation
{
    [_container.layer removeAnimationForKey:ROTATE_ANIMATION];
    [_pathLayer removeAnimationForKey:STROKE_ANIMATION];
}

- (void)changeProgress:(CGFloat)progress
{
    CGFloat myprogress = MAX(1.5 - progress, 0.25);
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    _container.layer.transform = CATransform3DMakeRotation(progress * 10, 0, 0, 1);
    _pathLayer.strokeStart = myprogress;
    _view.layer.opacity = progress - 0.5;
    [CATransaction commit];
}

- (void)layoutSubviewsWith:(UIView *)superView
{
    CGFloat height = CGRectGetHeight(superView.bounds);
    CGFloat width = CGRectGetWidth(superView.bounds);
    if (_view.superview == nil)
    {
        _view =
            [[UIView alloc] initWithFrame:(CGRect){(width - 40) / 2, (height - 40) / 2, 40, 40}];
        _view.layer.backgroundColor = [UIColor whiteColor].CGColor;
        _view.layer.cornerRadius = CGRectGetWidth(_view.bounds) / 2;
        _view.layer.shadowOffset = CGSizeMake(0, 0.7);
        _view.layer.shadowColor = [UIColor blackColor].CGColor;
        _view.layer.shadowRadius = 1.0;
        _view.layer.shadowOpacity = 0.12;
        [superView addSubview:_view];

        _container = [[UIView alloc] initWithFrame:_view.bounds];
        _container.backgroundColor = [UIColor clearColor];
        [_view addSubview:_container];

        // shaplayer
        UIBezierPath *path =
            [UIBezierPath bezierPathWithArcCenter:CGPointMake(CGRectGetWidth(_container.bounds) / 2,
                                                              CGRectGetWidth(_container.bounds) / 2)
                                           radius:CGRectGetWidth(_container.bounds) / 4
                                       startAngle:0
                                         endAngle:2 * M_PI
                                        clockwise:YES];
        _pathLayer = [CAShapeLayer layer];
        _pathLayer.fillColor = nil;
        _pathLayer.strokeColor = ((UIColor *)[_colors firstObject]).CGColor;
        _pathLayer.lineWidth = 3;
        _pathLayer.strokeStart = 1;
        _pathLayer.strokeEnd = 1;
        _pathLayer.lineCap = kCALineCapRound;
        _pathLayer.path = path.CGPath;
        [_container.layer addSublayer:_pathLayer];
    }
}

- (void)changeColor
{

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1.5 * NSEC_PER_SEC), dispatch_get_main_queue(),
                   ^{
                     [self changeColor];
                   });

    _colorIndex++;
    if (_colorIndex > _colors.count - 1)
    {
        _colorIndex = 0;
    }

    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    _pathLayer.strokeColor = ((UIColor *)_colors[_colorIndex]).CGColor;
    [CATransaction commit];
}

@end
