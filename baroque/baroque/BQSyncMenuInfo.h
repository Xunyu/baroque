//
//  BQSyncMenuInfo.h
//  baroque
//
//  Created by Sn Dev on 13-5-8.
//  Copyright (c) 2013年 Baroque. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
@interface BQSyncMenuInfo : NSObject
    <ASIHTTPRequestDelegate>


+ (BQSyncMenuInfo *)sharedInstance;
- (void)beginSync;
- (void)endSync;
@end
