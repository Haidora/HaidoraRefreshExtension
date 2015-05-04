//
//  HDGifAnimator.m
//  Pods
//
//  Created by Dailingchi on 15/5/3.
//
//

#import "HDGifAnimator.h"

@interface HDGifAnimator ()

@property (nonatomic, strong) UIImageView *gifImageView;

@end

@implementation HDGifAnimator

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.progressImage = [[UIImage alloc]
            initWithContentsOfFile:[[[NSBundle mainBundle] resourcePath]
                                       stringByAppendingPathComponent:
                                           @"HaidoraRefreshExtensionGif.bundle/progress@2x.gif"]];
        self.loadingImage = [[UIImage alloc]
            initWithContentsOfFile:[[[NSBundle mainBundle] resourcePath]
                                       stringByAppendingPathComponent:
                                           @"HaidoraRefreshExtensionGif.bundle/loading@2x.gif"]];
    }
    return self;
}

- (UIImageView *)gifImageView
{
    if (nil == _gifImageView)
    {
        _gifImageView = [[UIImageView alloc] init];
        _gifImageView.contentMode = UIViewContentModeScaleAspectFit;
        _gifImageView.backgroundColor = [UIColor clearColor];
    }
    return _gifImageView;
}

- (void)startLoadingAnimation
{
    self.gifImageView.animationImages = self.loadingImage.images;
    [self.gifImageView startAnimating];
}

- (void)stopLoadingAnimation
{
    [self.gifImageView stopAnimating];
    self.gifImageView.image = [self.progressImage.images firstObject];
}

- (void)changeProgress:(CGFloat)progress
{
    NSInteger index = (NSInteger)roundf((self.progressImage.images.count - 1) * (progress)) %
                      (self.progressImage.images.count);
    if (index < self.progressImage.images.count)
    {
        self.gifImageView.image = [self.self.progressImage.images objectAtIndex:index];
    }
}

- (void)layoutSubviewsWith:(UIView *)superView
{
    if (self.gifImageView.superview == nil)
    {
        self.gifImageView.frame = superView.bounds;
        self.gifImageView.image = [self.progressImage.images firstObject];
        [superView addSubview:self.gifImageView];
    }
}

@end
