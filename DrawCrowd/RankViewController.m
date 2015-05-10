//
//  RankViewController.m
//  DrawCrowd
//
//  Created by liujin on 15/5/6.
//  Copyright (c) 2015年 Jin Liu. All rights reserved.
//

#import "RankViewController.h"
#import "RankProjectCell.h"
#import <SDWebImage/UIImageView+WebCache.h>


@interface RankViewController () <UITableViewDelegate, UITableViewDataSource>
@end


@implementation RankViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"RankProjectCell0";
    RankProjectCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    [cell.image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://lorempixel.com/500/500/sports/%ld/", indexPath.row]]];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}





















#pragma mark - XLPagerTabStripViewControllerDelegate

-(NSString *)titleForPagerTabStripViewController:(XLPagerTabStripViewController *)pagerTabStripViewController
{
    return @"人气榜";
}

-(UIColor *)colorForPagerTabStripViewController:(XLPagerTabStripViewController *)pagerTabStripViewController
{
    return [UIColor whiteColor];
}


@end
