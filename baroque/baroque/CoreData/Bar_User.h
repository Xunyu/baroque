//
//  Bar_User.h
//  baroque
//
//  Created by Sn Dev on 13-6-4.
//  Copyright (c) 2013年 Baroque. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Bar_Order;

@interface Bar_User : NSManagedObject

@property (nonatomic, retain) NSDate * lastLoginDate;
@property (nonatomic, retain) NSString * password;
@property (nonatomic, retain) NSString * phone;
@property (nonatomic, retain) NSNumber * power;
@property (nonatomic, retain) NSNumber * userid;
@property (nonatomic, retain) NSString * username;
@property (nonatomic, retain) NSSet *userIDrelationship;
@end

@interface Bar_User (CoreDataGeneratedAccessors)

- (void)addUserIDrelationshipObject:(Bar_Order *)value;
- (void)removeUserIDrelationshipObject:(Bar_Order *)value;
- (void)addUserIDrelationship:(NSSet *)values;
- (void)removeUserIDrelationship:(NSSet *)values;

@end
