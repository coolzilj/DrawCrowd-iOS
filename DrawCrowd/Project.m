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
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:13.0],
                                 NSForegroundColorAttributeName: [UIColor whiteColor]};
    if (!_title) {
        return [[NSAttributedString alloc] initWithString:@"" attributes:attributes];
    } else {
        return [[NSAttributedString alloc] initWithString:_title attributes:attributes];
    }

}

@end
