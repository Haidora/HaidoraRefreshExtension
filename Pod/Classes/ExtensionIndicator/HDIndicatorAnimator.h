//
//  HDIndicatorAnimator.h
//  HaidoraRefreshExtension
//
//  Created by Dailingchi on 15/5/6.
//  Copyright (c) 2015年 mrdaios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import <HaidoraRefreshDefine.h>

#import <AnimatedGIFImageSerialization.h>

// fork from https://github.com/ermalkaleci/CarbonKit
@interface HDIndicatorAnimator : NSObject <HaidoraRefreshAnimator>

@property (nonatomic, assign) HDRefreshViewPosition position;
@property (nonatomic, copy) NSArray *colors;

@end
