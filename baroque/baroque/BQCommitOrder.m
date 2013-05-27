//
//  BQCommitOrder.m
//  baroque
//
//  Created by Sn Dev on 13-5-24.
//  Copyright (c) 2013年 Baroque. All rights reserved.
//

#import "BQCommitOrder.h"

@implementation BQCommitOrder
+ (BQCommitOrder *)sharedInstance
{
    static dispatch_once_t pred = 0;
    __strong static BQCommitOrder *_sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[BQCommitOrder alloc]init];
    });
    return _sharedObject;
}
- (void)beginCommitOrderWithPeopleCount:(int)peopleCount withTableID:(int)tableID
{
    NSURL *url = [NSURL URLWithString:@"http://baroque.sinaapp.com/order/commit"];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setRequestMethod:@"POST"];
    [request addPostValue:[NSString stringWithFormat:@"%d",peopleCount] forKey:@"customerCount"];
    [request addPostValue:[NSString stringWithFormat:@"%d",tableID] forKey:@"tableId"];
    [request setDelegate:self];
    NSArray *orderInfo = [BQCoreDataUtil fetchDataWithEntity:@"Bar_OrderDetail"];
    for (Bar_OrderDetail *item in orderInfo) {
        [request addPostValue:[item menuID] forKey:@"foodId"];
        [request addPostValue:[item count] forKey:@"count"];
        [request addPostValue:@"1" forKey:@"tasty"];
    }
    [request startAsynchronous];
}
- (void)endCommitOrder
{
    
}
- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSError *error;
    NSData *responseData = [request responseData];
    NSLog(@"%@",responseData);
    NSDictionary *receiveDictionary = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&error];
    NSNumber *receiveCode = [receiveDictionary objectForKey:@"code"];
    if ([receiveCode isEqualToNumber:[NSNumber numberWithLong:200]]){
        NSString *receiveResult = [receiveDictionary objectForKey:@"msg"];
        NSLog(@"%@",receiveResult);
    }
}
- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
    NSLog(@"%@",error);
}
@end
