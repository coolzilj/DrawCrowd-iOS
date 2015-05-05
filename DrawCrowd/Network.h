//
//  Network.h
//  DrawCrowd
//
//  Created by liujin on 15/5/5.
//  Copyright (c) 2015年 Jin Liu. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface Network : AFHTTPSessionManager

+ (Network *)sharedInstance;

+ (void)getNewDiscoveriesWithPage:(NSInteger)page
                       completion:(void (^)(NSArray *projectsArray))completion;

@end
