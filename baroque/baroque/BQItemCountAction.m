//
//  BQItemCountAction.m
//  baroque
//
//  Created by Sn Dev on 13-5-23.
//  Copyright (c) 2013年 Baroque. All rights reserved.
//

#import "BQItemCountAction.h"

@implementation BQItemCountAction
+ (NSString*)itemCountPlusWithFoodID:(NSNumber*)foodID
{
    Bar_OrderDetail *orderDetail;
    NSManagedObjectContext *context = [BQCoreDataUtil sharedInstance].managedObjectContext;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"menuID = %@ && orderID = 0",foodID];
    NSArray *result = [BQCoreDataUtil fetchDataWithEntity:@"Bar_OrderDetail" andWithPredicate:predicate];
    if (result != nil && result.count > 0){
        orderDetail = [result lastObject];
        orderDetail.count = [NSNumber numberWithInt:[orderDetail.count intValue]+1];
    }
    else{
        orderDetail = [NSEntityDescription insertNewObjectForEntityForName:@"Bar_OrderDetail" inManagedObjectContext:context];
        orderDetail.menuID = foodID;
        orderDetail.addDate = [NSDate date];
        orderDetail.count = [NSNumber numberWithInt:1];
        predicate = [NSPredicate predicateWithFormat:@"foodID = %@",foodID];
        orderDetail.menuIDrelationship = [[BQCoreDataUtil fetchDataWithEntity:@"Bar_Menu" andWithPredicate:predicate] lastObject];
        predicate = [NSPredicate predicateWithFormat:@"orderID = 0"];
        Bar_Order *orderResult = [[BQCoreDataUtil fetchDataWithEntity:@"Bar_Order" andWithPredicate:predicate]lastObject];
        if (orderResult != nil){
            orderDetail.orderIDrelationship = orderResult;
        }
        else{
            orderResult = [NSEntityDescription insertNewObjectForEntityForName:@"Bar_Order" inManagedObjectContext:context];
            orderResult.orderID = [NSNumber numberWithInt:0];
            orderDetail.orderIDrelationship = orderResult;
        }
    }
    NSError *error = nil;
    [context save:&error];
    return [orderDetail.count stringValue];
}
+ (NSString*)itemCountMinusWithFoodID:(NSNumber*)foodID
{
    Bar_OrderDetail *orderDetail;
    NSManagedObjectContext *context = [BQCoreDataUtil sharedInstance].managedObjectContext;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"menuID = %@ && orderID = 0",foodID];
    [fetchRequest setEntity:[NSEntityDescription entityForName:@"Bar_OrderDetail" inManagedObjectContext:context]];
    [fetchRequest setPredicate:predicate];
    NSError *error = nil;
    NSArray *result = [context executeFetchRequest:fetchRequest error:&error];
    if (result != nil && result.count > 0 ){
        orderDetail = [result lastObject];
        int count = [orderDetail.count intValue];
        if (count == 1){
            [context deleteObject:orderDetail];
            [context save:&error];
            return @"0";
        }
        else{
            orderDetail.count = [NSNumber numberWithInt:[orderDetail.count intValue]-1];
            [context save:&error];
            return [orderDetail.count stringValue];
        }
    }
    [context save:&error];
    return @"0";
}
+ (NSString*)getItemCountWithFoodID:(NSNumber*)foodID
{
    Bar_OrderDetail *orderDetail;
    NSManagedObjectContext *context = [BQCoreDataUtil sharedInstance].managedObjectContext;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"menuID = %@ && orderID = 0",foodID];
    [fetchRequest setEntity:[NSEntityDescription entityForName:@"Bar_OrderDetail" inManagedObjectContext:context]];
    [fetchRequest setPredicate:predicate];
    NSError *error = nil;
    NSArray *result = [context executeFetchRequest:fetchRequest error:&error];
    if (result != nil && result.count>0){
        orderDetail = [result lastObject];
        return [orderDetail.count stringValue];
    }
    else{
        return @"0";
    }
    
}
@end
