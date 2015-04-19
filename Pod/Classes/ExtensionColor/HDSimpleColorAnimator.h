//
//  HDSimpleColorAnimator.h
//  Pods
//
//  Created by Dailingchi on 15/4/16.
//
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <HaidoraRefreshDefine.h>

// fork from https://github.com/inspace-io/INSPullToRefresh
@interface HDSimpleColorAnimator : NSObject <HaidoraRefreshAnimator>

@property (nonatomic, assign) HDRefreshViewPosition position;

@property (nonatomic, strong) UIColor *normalColor;
@property (nonatomic, strong) UIColor *triggeredColor;
@property (nonatomic, strong) UIColor *loadingColor;

@end
