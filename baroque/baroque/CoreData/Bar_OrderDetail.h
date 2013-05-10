//
//  Bar_OrderDetail.h
//  baroque
//
//  Created by Sn Dev on 13-5-9.
//  Copyright (c) 2013年 Baroque. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Bar_Menu, Bar_Order;

@interface Bar_OrderDetail : NSManagedObject

@property (nonatomic, retain) NSDate * addDate;
@property (nonatomic, retain) NSNumber * backReason;
@property (nonatomic, retain) NSNumber * count;
@property (nonatomic, retain) NSNumber * menuID;
@property (nonatomic, retain) NSNumber * orderDetailID;
@property (nonatomic, retain) NSNumber * orderID;
@property (nonatomic, retain) NSNumber * statue;
@property (nonatomic, retain) NSDate * updateDate;
@property (nonatomic, retain) Bar_Menu *menuIDrelationship;
@property (nonatomic, retain) Bar_Order *orderIDrelationship;

@end
