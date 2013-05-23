//
//  BQSyncMenuInfo.h
//  baroque
//
//  Created by Sn Dev on 13-5-8.
//  Copyright (c) 2013年 Baroque. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "BQCoreDataUtil.h"
#import "Bar_Menu.h"
#import "Bar_OrderDetail.h"
@interface BQSyncMenuInfo : NSObject
    <ASIHTTPRequestDelegate>
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

+ (BQSyncMenuInfo *)sharedInstance;
- (void)beginSync;
- (void)endSync;
@end
