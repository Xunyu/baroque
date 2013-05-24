//
//  BQPostOrderViewController.h
//  baroque
//
//  Created by Sn Dev on 13-4-18.
//  Copyright (c) 2013年 Baroque. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BQCommitOrder.h"
@interface BQPostOrderViewController : UIViewController
- (IBAction)backButtonTapped:(id)sender;
- (IBAction)confirmPostButtonTapped:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *userNumber;
@property (weak, nonatomic) IBOutlet UITextField *userPassword;
@property (weak, nonatomic) IBOutlet UITextField *peopleCount;
@property (weak, nonatomic) IBOutlet UITextField *tableID;

@end
