//
//  Network.m
//  DrawCrowd
//
//  Created by liujin on 15/5/5.
//  Copyright (c) 2015年 Jin Liu. All rights reserved.
//

#import "Network.h"
#import "Project.h"
#import <MJExtension/MJExtension.h>
#import <SVProgressHUD/SVProgressHUD.h>

@implementation Network

+ (Network *)sharedInstance {
    static Network *singleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [[Network alloc] initWithBaseURL:[NSURL URLWithString:@"http://drawcrowd.com"]];
        singleton.requestSerializer.timeoutInterval = 30.0;
        singleton.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingMutableContainers];
        singleton.responseSerializer.acceptableContentTypes = [singleton.responseSerializer.acceptableContentTypes setByAddingObjectsFromSet:[NSSet setWithObject:@"text/html"]];
    });
    return singleton;
}

+ (void)getNewDiscoveriesWithPage:(NSInteger)page completion:(void (^)(NSArray *))completion {
    [[Network sharedInstance] GET:@"/new_discoveries"
                       parameters:@{@"page": [@(page) stringValue],
                                    @"cat": @"featured"}
                          success:^(NSURLSessionDataTask *task, id responseObject) {
                              if (responseObject &&
                                  [responseObject[@"projects"] isKindOfClass:[NSString class]] &&
                                  [responseObject[@"projects"] isEqualToString:@"END"]) {
                                  completion(nil);
                                  [SVProgressHUD showErrorWithStatus:@"解析出错"];
                              } else {
                                  [Project setupReplacedKeyFromPropertyName:^NSDictionary *{
                                      return @{@"desc" : @"description"};
                                  }];
                                  NSMutableArray *projectsArray = [NSMutableArray arrayWithArray:[Project objectArrayWithKeyValuesArray:responseObject[@"projects"]]];
                                  completion(projectsArray);
                              }
                          }
                          failure:^(NSURLSessionDataTask *task, NSError *error) {
                              completion(nil);
                              [SVProgressHUD showErrorWithStatus:@"网络出问题了"];
                          }];
}

@end
