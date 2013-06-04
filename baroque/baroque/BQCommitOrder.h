//
//  BQCommitOrder.h
//  baroque
//
//  Created by Sn Dev on 13-5-24.
//  Copyright (c) 2013年 Baroque. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "BQCoreDataUtil.h"
#import "Bar_OrderDetail.h"
#import "Bar_Order.h"
@interface BQCommitOrder : NSObject
    <ASIHTTPRequestDelegate>

+ (BQCommitOrder*)sharedInstance;
- (void)beginCommitOrderWithPeopleCount:(int)peopleCount withTableID:(int)tableID;
- (void)endCommitOrder;
@end
