//
//  HDGifAnimator.h
//  Pods
//
//  Created by Dailingchi on 15/5/3.
//
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <HaidoraRefreshDefine.h>

#import <AnimatedGIFImageSerialization.h>

// fork from https://github.com/uzysjung/UzysAnimatedGifPullToRefresh
@interface HDGifAnimator : NSObject <HaidoraRefreshAnimator>

@property (nonatomic, assign) HDRefreshViewPosition position;

/**
 *  Need gif PathExtension
 */
@property (nonatomic, strong) UIImage *progressImage;
@property (nonatomic, strong) UIImage *loadingImage;

@end
