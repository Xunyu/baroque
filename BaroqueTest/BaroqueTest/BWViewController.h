//
//  BWViewController.h
//  BaroqueTest
//
//  Created by Mr.Xun on 13-3-3.
//  Copyright (c) 2013年 Mr.Xun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BWViewController : UIViewController
@property (strong,nonatomic) IBOutlet UITextField *aNum;
@property (strong,nonatomic) IBOutlet UITextField *bNum;
@property (strong,nonatomic) IBOutlet UILabel *answer;
- (IBAction)buttonPressed:(id)sender;
- (IBAction) backgroundTap: (id)sender;
-(NSString *)testRequestWithNumberA:(int)a AndNumB:(int)b;
-(NSString *)testRequestWithStringA:(NSString *)a AndStrB:(NSString *)b;

@end
