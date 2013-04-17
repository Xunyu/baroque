//
//  BQDetailViewController.h
//  pageViewController
//
//  Created by Sn Dev on 13-4-17.
//  Copyright (c) 2013年 Baroque. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BQDetailViewController : UIViewController

+ (BQDetailViewController*)detailViewControllerForPageIndex:(NSUInteger)pageIndex;
- (NSInteger)pageIndex;
@property (weak, nonatomic) IBOutlet UILabel *number;
@end
