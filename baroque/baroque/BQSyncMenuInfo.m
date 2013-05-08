//
//  BQSyncMenuInfo.m
//  baroque
//
//  Created by Sn Dev on 13-5-8.
//  Copyright (c) 2013年 Baroque. All rights reserved.
//

#import "BQSyncMenuInfo.h"

@implementation BQSyncMenuInfo
+ (BQSyncMenuInfo *)sharedInstance
{
    static dispatch_once_t pred = 0;
    __strong static BQSyncMenuInfo *_sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[BQSyncMenuInfo alloc]init];
    });
    return _sharedObject;
}
- (void)beginSync
{
    NSURL *url = [NSURL URLWithString:@"XXXX"];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setDelegate:self];
    [request startAsynchronous];
}
- (void)endSync
{
    
}
#pragma mark - ASIHttpRequest Delegate
- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSError *error;
    NSData *responseData = [request responseData];
    NSDictionary *menuDictionary = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&error];
    
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
    NSLog(@"%@",error);
}
@end
