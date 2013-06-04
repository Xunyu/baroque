//
//  Bar_Room.h
//  baroque
//
//  Created by Sn Dev on 13-6-4.
//  Copyright (c) 2013年 Baroque. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Bar_Table;

@interface Bar_Room : NSManagedObject

@property (nonatomic, retain) NSString * level;
@property (nonatomic, retain) NSNumber * roomID;
@property (nonatomic, retain) NSString * roomName;
@property (nonatomic, retain) Bar_Table *roomIDrelationship;

@end
