//
//  AppDelegate.m
//  DrawCrowd
//
//  Created by liujin on 15/5/4.
//  Copyright (c) 2015年 Jin Liu. All rights reserved.
//

#import "AppDelegate.h"
#import "LeftMenuViewController.h"
#import <AFNetworking/AFNetworkActivityIndicatorManager.h>
#import <iOS-Slide-Menu/SlideNavigationController.h>

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    [self setupMenuViewController];
    return YES;
}

# pragma mark - private methods
#
- (void)setupMenuViewController {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LeftMenuViewController *leftMenuVC = [sb instantiateViewControllerWithIdentifier:@"LeftMenu"];
    [SlideNavigationController sharedInstance].leftMenu = leftMenuVC;
    [SlideNavigationController sharedInstance].rightMenu = nil;

    [SlideNavigationController sharedInstance].enableShadow = YES;
    [SlideNavigationController sharedInstance].enableSwipeGesture = YES;
    [SlideNavigationController sharedInstance].avoidSwitchingToSameClassViewController = NO;
    [[SlideNavigationController sharedInstance] setPortraitSlideOffset:SCREEN_WIDTH - 100];
    [[SlideNavigationController sharedInstance] setLandscapeSlideOffset:SCREEN_HEIGHT - 100];
}

@end
