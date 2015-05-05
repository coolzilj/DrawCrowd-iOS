//
//  Project.m
//  DrawCrowd
//
//  Created by liujin on 15/5/4.
//  Copyright (c) 2015年 Jin Liu. All rights reserved.
//

#import "Project.h"

@implementation Project

- (NSAttributedString *)attributedCaptionTitle {
    NSDictionary *attrs = @{NSFontAttributeName: [UIFont systemFontOfSize:13.0], NSForegroundColorAttributeName: [UIColor whiteColor]};
    if (!_title) {
        return [[NSAttributedString alloc] initWithString:@"" attributes:attrs];
    } else {
        return [[NSAttributedString alloc] initWithString:_title attributes:attrs];
    }
}

- (NSAttributedString *)attributedCaptionSummary {
    NSDictionary *attrs = @{NSFontAttributeName: [UIFont systemFontOfSize:10.0], NSForegroundColorAttributeName: [UIColor colorWithWhite:0.8 alpha:1.000]};
    if (!_desc) {
        return [[NSAttributedString alloc] initWithString:@"" attributes:attrs];
    } else {
        return [[NSAttributedString alloc] initWithString:_desc attributes:attrs];
    }
}

@end
