//
//  UserDefault.m
//  SNSmartHome
//
//  Created by Dev Sn on 12-7-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UserDefault.h"

@implementation UserDefault
+ (void)saveToUserDefaults:(NSString*)tosaveedString withKey:(NSString *)tosaveedKey
{
    NSUserDefaults *tmp = [NSUserDefaults standardUserDefaults];  
    if (tmp) {  
        [tmp setObject:tosaveedString forKey:tosaveedKey];  
        [tmp synchronize];  
    }  
}
+ (void)saveToUserDefaultsWithBoolValue:(BOOL)tosaveedBoolValue withKey:(NSString *)tosaveedKey
{
    NSUserDefaults *tmp = [NSUserDefaults standardUserDefaults];
    if (tmp) {
        [tmp setBool:tosaveedBoolValue forKey:tosaveedKey];
        [tmp synchronize];
    }
}
+ (NSString *)restoreFromUserDefaults:(NSString *)key
{  
    NSString *rtn = nil;  
    NSUserDefaults *tmp = [NSUserDefaults standardUserDefaults];  
    if (tmp) {  
        rtn = [tmp objectForKey:key];  
    }  
    return rtn;  
}
+ (BOOL)restoreBoolValueFromUserDefaults:(NSString *)key defaultValve:(BOOL)defaultValue
{
    BOOL rtn = defaultValue;
    NSUserDefaults *tmp = [NSUserDefaults standardUserDefaults];
    if (tmp){
        NSObject *temp = [tmp objectForKey:key];
        if (temp){
            rtn = [tmp boolForKey:key];
        }
    }
    return rtn;
}
+ (BOOL)restoreBoolValueFromUserDefaults:(NSString *)key
{
    return [self restoreBoolValueFromUserDefaults:key defaultValve:NO];
}
@end
