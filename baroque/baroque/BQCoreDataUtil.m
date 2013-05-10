//
//  BQCoreDataUtil.m
//  baroque
//
//  Created by Sn Dev on 13-5-10.
//  Copyright (c) 2013年 Baroque. All rights reserved.
//

#import "BQCoreDataUtil.h"

@implementation BQCoreDataUtil
@synthesize managedObjectContext=_managedObjectContext;
@synthesize managedObjectModel=_managedObjectModel;
@synthesize persistentStoreCoordinator=_persistentStoreCoordinator;

+ (BQCoreDataUtil *)sharedInstance
{
    static dispatch_once_t pred = 0;
    __strong static BQCoreDataUtil *_sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[BQCoreDataUtil alloc]init];
    });
    return _sharedObject;
}
- (NSManagedObjectContext*)managedObjectContext
{
    if (_managedObjectContext != nil){
        return _managedObjectContext;
    }
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator !=nil){
        _managedObjectContext = [[NSManagedObjectContext alloc]init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}
- (NSManagedObjectModel*)managedObjectModel{
    if (_managedObjectModel != nil){
        return _managedObjectModel;
    }
    NSURL *modalURL= [[NSBundle mainBundle]URLForResource:@"menu" withExtension:@"data"];
    _managedObjectModel = [[NSManagedObjectModel alloc]initWithContentsOfURL:modalURL];
    return _managedObjectModel;
}
- (NSPersistentStoreCoordinator*)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil){
        return _persistentStoreCoordinator;
    }
    NSError *error = nil;
    NSURL *storeURL = [[[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject]URLByAppendingPathComponent:@"menu.sqlite"];
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:_managedObjectModel];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]){
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    return _persistentStoreCoordinator;
}

@end
