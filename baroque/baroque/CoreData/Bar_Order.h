//
//  Bar_Order.h
//  baroque
//
//  Created by Sn Dev on 13-5-9.
//  Copyright (c) 2013年 Baroque. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Bar_OrderDetail, Bar_Table, Bar_User;

@interface Bar_Order : NSManagedObject

@property (nonatomic, retain) NSDate * addDate;
@property (nonatomic, retain) NSNumber * discount;
@property (nonatomic, retain) NSNumber * finalAmaont;
@property (nonatomic, retain) NSNumber * loginID;
@property (nonatomic, retain) NSNumber * orderID;
@property (nonatomic, retain) NSNumber * people;
@property (nonatomic, retain) NSDecimalNumber * preAmount;
@property (nonatomic, retain) NSDecimalNumber * reductionAmount;
@property (nonatomic, retain) NSNumber * tableID;
@property (nonatomic, retain) Bar_User *loginIDrelationship;
@property (nonatomic, retain) NSSet *orderIDrelationship;
@property (nonatomic, retain) Bar_Table *tableIDrelationship;
@end

@interface Bar_Order (CoreDataGeneratedAccessors)

- (void)addOrderIDrelationshipObject:(Bar_OrderDetail *)value;
- (void)removeOrderIDrelationshipObject:(Bar_OrderDetail *)value;
- (void)addOrderIDrelationship:(NSSet *)values;
- (void)removeOrderIDrelationship:(NSSet *)values;

@end
