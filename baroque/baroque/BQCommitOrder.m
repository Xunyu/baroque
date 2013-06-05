//
//  BQCommitOrder.m
//  baroque
//
//  Created by Sn Dev on 13-5-24.
//  Copyright (c) 2013年 Baroque. All rights reserved.
//

#import "BQCommitOrder.h"

@implementation BQCommitOrder
{
    int people;
    int table;
}
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
    people = peopleCount;
    table = tableID;
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
    NSError *error = nil;
    NSData *responseData = [request responseData];
    NSLog(@"%@",responseData);
    NSDictionary *receiveDictionary = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&error];
    NSNumber *receiveCode = [receiveDictionary objectForKey:@"code"];
    if ([receiveCode isEqualToNumber:[NSNumber numberWithLong:200]]){
        NSString *receiveResult = [receiveDictionary objectForKey:@"msg"];
        NSLog(@"%@",receiveResult);
        NSDictionary *receiveBody = [receiveDictionary objectForKey:@"body"];
        NSString *receiveOrderId = [receiveBody objectForKey:@"orderId"];
        NSLog(@"%@",receiveOrderId);
        [UserDefault saveToUserDefaults:receiveOrderId withKey:@"lastOrderId"];
        Bar_Order *newOrder = [NSEntityDescription insertNewObjectForEntityForName:@"Bar_Order" inManagedObjectContext:[BQCoreDataUtil sharedInstance].managedObjectContext];
        newOrder.orderID = [NSNumber numberWithInt:[receiveOrderId intValue]];
        newOrder.addDate = [NSDate date];
        newOrder.people = [NSNumber numberWithInt:people];
        newOrder.tableID = [NSNumber numberWithInt:table];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"orderID = 0"];
        NSArray *postedOrderDetail = [BQCoreDataUtil fetchDataWithEntity:@"Bar_OrderDetail" andWithPredicate:predicate];
        for (Bar_OrderDetail *detail in postedOrderDetail) {
            detail.orderIDrelationship = newOrder;
            detail.orderID = [NSNumber numberWithInt:[receiveOrderId intValue]];
            detail.updateDate = [NSDate date];
        }
        [[BQCoreDataUtil sharedInstance].managedObjectContext save:&error];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"refreshOrderDetail" object:nil];
    }
}
- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
    NSLog(@"%@",error);
}
@end
