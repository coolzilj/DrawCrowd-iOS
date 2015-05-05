//
//  Project.h
//  DrawCrowd
//
//  Created by liujin on 15/5/4.
//  Copyright (c) 2015年 Jin Liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <NYTPhotoViewer/NYTPhoto.h>

@interface Project : NSObject <NYTPhoto>

@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *small_image;
@property (nonatomic, strong) NSString *medium_image;
@property (nonatomic, strong) NSString *large_image;
@property (nonatomic, strong) NSString *original_image;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSString *title;

// NYTPhoto required
@property (nonatomic) UIImage *image;
@property (nonatomic) UIImage *placeholderImage;
@property (nonatomic) NSAttributedString *attributedCaptionTitle;
@property (nonatomic) NSAttributedString *attributedCaptionSummary;
@property (nonatomic) NSAttributedString *attributedCaptionCredit;

@end
