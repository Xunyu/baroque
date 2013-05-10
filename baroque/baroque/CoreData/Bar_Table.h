//
//  Bar_Table.h
//  baroque
//
//  Created by Sn Dev on 13-5-9.
//  Copyright (c) 2013年 Baroque. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Bar_Order, Bar_Room;

@interface Bar_Table : NSManagedObject

@property (nonatomic, retain) NSNumber * isAvaliable;
@property (nonatomic, retain) NSNumber * numbers;
@property (nonatomic, retain) NSNumber * roomID;
@property (nonatomic, retain) NSNumber * tableID;
@property (nonatomic, retain) NSString * tableName;
@property (nonatomic, retain) Bar_Room *roomIDrelationship;
@property (nonatomic, retain) Bar_Order *tableIDrelationship;

@end
