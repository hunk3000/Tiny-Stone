//
//  KeyChainHelper.h
//  superHDPaper
//
//  Created by Hunk on 14-4-11.
//  Copyright (c) 2014年 your company. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KeyChainHelper : NSObject

+(void)save:(NSString *)service data:(id)data;
+ (id)load:(NSString *)service;
+ (void)deleteData:(NSString *)service;

@end
