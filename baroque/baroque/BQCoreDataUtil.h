//
//  BQCoreDataUtil.h
//  baroque
//
//  Created by Sn Dev on 13-5-10.
//  Copyright (c) 2013年 Baroque. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface BQCoreDataUtil : NSObject

@property (nonatomic,strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic,strong) NSManagedObjectModel *managedObjectModel;
@property (nonatomic,strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;

+ (BQCoreDataUtil*)sharedInstance;
@end
