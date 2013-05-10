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
    NSDictionary *receiveDictionary = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&error];
    NSString *receiveCode = [receiveDictionary objectForKey:@"code"];
    if ([receiveCode isEqualToString:@"200"]){
        NSArray *menuArray = [receiveDictionary objectForKey:@"menu"];
        for (int i = 0 ; i < [menuArray count]; i++) {
            NSDictionary *item = [menuArray objectAtIndex:i];
            self.managedObjectContext = [BQCoreDataUtil sharedInstance].managedObjectContext;
            Bar_Menu *menu = [NSEntityDescription insertNewObjectForEntityForName:@"Bar_Menu" inManagedObjectContext:self.managedObjectContext];
            menu.foodID = [item objectForKey:@"foodId"];
            menu.foodName = [item objectForKey:@"foodName"];
            menu.price = [item objectForKey:@"price"];
            menu.foodType = [item objectForKey:@"foodType"];
            menu.tastyType = [item objectForKey:@"tastyType"];
            menu.picUrl = [item objectForKey:@"picUrl"];
            NSError *error = nil;
            [self.managedObjectContext save:&error];
        }
    }
    
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
    NSLog(@"%@",error);
}
@end
