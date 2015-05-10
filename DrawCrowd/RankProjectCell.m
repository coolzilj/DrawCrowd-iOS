//
//  RankProjectCell.m
//  DrawCrowd
//
//  Created by liujin on 15/5/7.
//  Copyright (c) 2015年 Jin Liu. All rights reserved.
//

#import "RankProjectCell.h"

@interface RankProjectCell()
@property (weak, nonatomic) IBOutlet UIView *detailsOverlay;
@end

@implementation RankProjectCell

- (void)awakeFromNib {
    // set background gradient
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.detailsOverlay.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor clearColor] CGColor], (id)[[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5] CGColor], nil];
    [self.detailsOverlay.layer insertSublayer:gradient atIndex:0];
    // set border radius
    self.rankPosition.layer.masksToBounds = YES;
    self.rankPosition.layer.cornerRadius = 20.0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

}



@end
