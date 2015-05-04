//
//  HDViewController.m
//  HaidoraRefreshExtension
//
//  Created by mrdaios on 04/16/2015.
//  Copyright (c) 2014 mrdaios. All rights reserved.
//

#import "HDViewController.h"
#import <HaidoraRefresh.h>
#import <HaidoraRefreshExtension.h>

@interface HDViewController ()

@end

@implementation HDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    __weak typeof(self) weakself = self;
    self.tableView.tableFooterView = [[UIView alloc] init];
    // Do any additional setup after loading the view, typically from a nib.
    [self.tableView addPullToRefreshWithActionHandler:^{
      dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)),
                     dispatch_get_main_queue(), ^{
                       [weakself.tableView stopPullRefresh];
                     });
    } animator:[[HDSimpleColorAnimator alloc] init]];

    HDSimpleColorAnimator *animator = [[HDSimpleColorAnimator alloc] init];
    [self.tableView addInfiniteToRefreshWithActionHandler:^{
      dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)),
                     dispatch_get_main_queue(), ^{
                       [weakself.tableView stopInfiniteRefresh];
                     });
    } animator:animator];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
