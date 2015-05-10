//
//  DiscoverViewController.m
//  DrawCrowd
//
//  Created by liujin on 15/5/6.
//  Copyright (c) 2015年 Jin Liu. All rights reserved.
//

#import "DiscoverViewController.h"
#import "NewestViewController.h"
#import "RankViewController.h"

@interface DiscoverViewController ()

@end

@implementation DiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isProgressiveIndicator = YES;
    self.isElasticIndicatorLimit = YES;
    [self.view setBackgroundColor:[UIColor blackColor]];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - XLPagerTabStripViewControllerDataSource

-(NSArray *)childViewControllersForPagerTabStripViewController:(XLPagerTabStripViewController *)pagerTabStripViewController
{
    NewestViewController *newestVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"NewestView"];
    RankViewController *rankVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"RankView"];
    return @[newestVC, rankVC];
}


@end

