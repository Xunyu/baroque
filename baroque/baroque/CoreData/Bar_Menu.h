//
//  Bar_Menu.h
//  baroque
//
//  Created by Sn Dev on 13-5-6.
//  Copyright (c) 2013年 Baroque. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Bar_OrderDetail;

@interface Bar_Menu : NSManagedObject

@property (nonatomic, retain) NSNumber * foodID;
@property (nonatomic, retain) NSString * foodName;
@property (nonatomic, retain) NSString * foodDescription;
@property (nonatomic, retain) NSNumber * foodType;
@property (nonatomic, retain) NSDecimalNumber * price;
@property (nonatomic, retain) NSDecimalNumber * cost;
@property (nonatomic, retain) NSNumber * categoryID;
@property (nonatomic, retain) NSNumber * tastyType;
@property (nonatomic, retain) NSString * picUrl;
@property (nonatomic, retain) NSDate * addDate;
@property (nonatomic, retain) NSNumber * kichenNum;
@property (nonatomic, retain) NSNumber * taste;
@property (nonatomic, retain) Bar_OrderDetail *foodIDrelationship;

@end
