//
//  BQCheckOrder.h
//  baroque
//
//  Created by Sn Dev on 13-5-28.
//  Copyright (c) 2013年 Baroque. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "Bar_Order.h"
@interface BQCheckOrder : NSObject

+ (BQCheckOrder *)sharedInstance;
- (void)beginCheckOrder;
- (void)endCheckOrder;
@end
