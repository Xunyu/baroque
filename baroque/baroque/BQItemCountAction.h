//
//  BQItemCountAction.h
//  baroque
//
//  Created by Sn Dev on 13-5-23.
//  Copyright (c) 2013年 Baroque. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BQCoreDataUtil.h"
#import "Bar_OrderDetail.h"
#import "Bar_Order.h"
@interface BQItemCountAction : NSObject
+ (NSString*)itemCountPlusWithFoodID:(NSNumber*)foodID;
+ (NSString*)itemCountMinusWithFoodID:(NSNumber*)foodID;
+ (NSString*)getItemCountWithFoodID:(NSNumber*)foodID;
@end
