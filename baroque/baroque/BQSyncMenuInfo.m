//
//  BQSyncMenuInfo.m
//  baroque
//
//  Created by Sn Dev on 13-5-8.
//  Copyright (c) 2013年 Baroque. All rights reserved.
//

#import "BQSyncMenuInfo.h"
@implementation BQSyncMenuInfo
@synthesize managedObjectContext = _managedObjectContext;

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
    NSURL *url = [NSURL URLWithString:@"http://baroque.sinaapp.com/menu/list"];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setRequestMethod:@"GET"];
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
    NSLog(@"%@",responseData);
    NSDictionary *receiveDictionary = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&error];
    NSNumber *receiveCode = [receiveDictionary objectForKey:@"code"];
    if ([receiveCode isEqualToNumber:[NSNumber numberWithLong:200]]){
        //清除原有菜单以及订单信息
        self.managedObjectContext = [BQCoreDataUtil sharedInstance].managedObjectContext;
        NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Bar_Menu"];
        NSError *error = nil;
        NSArray *result = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
        for (Bar_Menu *item in result) {
            [self.managedObjectContext deleteObject:item];
        }
        fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Bar_OrderDetail"];
        result = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
        for (Bar_OrderDetail *orderDetail in result) {
            [self.managedObjectContext deleteObject:orderDetail];
        }
        
        //保存菜单信息
        NSArray *menuArray = [receiveDictionary objectForKey:@"body"];
        for (int i = 0 ; i < [menuArray count]; i++) {
            NSDictionary *item = [menuArray objectAtIndex:i];
            Bar_Menu *menu = [NSEntityDescription insertNewObjectForEntityForName:@"Bar_Menu" inManagedObjectContext:self.managedObjectContext];
            menu.foodID = [item objectForKey:@"foodId"];
            menu.foodName = [item objectForKey:@"foodName"];
            menu.price = [item objectForKey:@"price"];
            menu.foodType = [item objectForKey:@"foodType"];
            if ([item objectForKey:@"tastyType"] != [NSNull null]) {
                menu.tastyType = [item objectForKey:@"tastyType"];
            }
            else{
                menu.tastyType = @"";
            }
            menu.picUrl = [item objectForKey:@"picUrl"];
            NSError *error = nil;
            [self.managedObjectContext save:&error];
        }
        //发送菜单同步通知
        [[NSNotificationCenter defaultCenter]postNotificationName:@"syncMenuInfoFinished" object:nil];
    }
    
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
    NSLog(@"%@",error);
}
@end
