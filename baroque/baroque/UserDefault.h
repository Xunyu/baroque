//
//  UserDefault.h
//  SNSmartHome
//
//  Created by Dev Sn on 12-7-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDefault : NSObject
+ (void)saveToUserDefaults:(NSString *)tosaveedString withKey:(NSString *)tosaveedKey;
+ (void)saveToUserDefaultsWithBoolValue:(BOOL)tosaveedBoolValue withKey:(NSString *)tosaveedKey;
+ (NSString *)restoreFromUserDefaults:(NSString *)key ;
+ (BOOL)restoreBoolValueFromUserDefaults:(NSString *)key defaultValve:(BOOL)defaultValue;
+ (BOOL)restoreBoolValueFromUserDefaults:(NSString *)key;
@end
