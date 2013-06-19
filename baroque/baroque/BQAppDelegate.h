//
//  BQAppDelegate.h
//  baroque
//
//  Created by Sn Dev on 13-4-8.
//  Copyright (c) 2013年 Baroque. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PSStackedView.h"
#define XAppDelegate ((BQAppDelegate *)[[UIApplication sharedApplication] delegate])

@interface BQAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) PSStackedViewController *stackController;

@end
