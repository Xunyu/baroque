//
//  BQDetailViewController.h
//  baroque
//
//  Created by Sn Dev on 13-4-12.
//  Copyright (c) 2013年 Baroque. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BQDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *dishImageView;
@property (weak, nonatomic) IBOutlet UILabel *dishName;
@property (weak, nonatomic) IBOutlet UILabel *dishUnitPrice;
@property (weak, nonatomic) IBOutlet UITextView *dishDescription;
@property (weak, nonatomic) IBOutlet UILabel *dishMount;
@property (weak, nonatomic) IBOutlet UILabel *dishCookWay;
@property (weak, nonatomic) IBOutlet UILabel *dishTaste;

- (IBAction)dishTasteEditButtonTouched:(id)sender;
- (IBAction)dishCookWayEditButtonTouched:(id)sender;
- (IBAction)backButtonTouched:(id)sender;


+ (BQDetailViewController *)detailViewControllerForPageIndex:(NSUInteger)pageIndex;
- (NSInteger)pageIndex;
@end
