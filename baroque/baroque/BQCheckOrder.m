//
//  BQCheckOrder.m
//  baroque
//
//  Created by Sn Dev on 13-5-28.
//  Copyright (c) 2013年 Baroque. All rights reserved.
//

#import "BQCheckOrder.h"

@implementation BQCheckOrder
+ (BQCheckOrder *)sharedInstance
{
    static dispatch_once_t pred = 0;
    __strong static BQCheckOrder *_sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[BQCheckOrder alloc]init];
    });
    return _sharedObject;
}
- (void)beginCheckOrder
{
    
    
}
- (void)endCheckOrder
{
    
}
@end
