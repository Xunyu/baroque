//
//  BWViewController.h
//  BaroqueTest
//
//  Created by Mr.Xun on 13-3-3.
//  Copyright (c) 2013年 Mr.Xun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "ASIHTTPRequestDelegate.h"
@interface BWViewController : UIViewController
<NSURLConnectionDelegate>
@property (strong,nonatomic) IBOutlet UITextField *aNum;
@property (strong,nonatomic) IBOutlet UITextField *bNum;
@property (strong,nonatomic) IBOutlet UILabel *answer;
- (IBAction)buttonPressed:(id)sender;
- (IBAction) backgroundTap: (id)sender;
//-(NSString *)testRequestWithNumberA:(int)a AndNumB:(int)b;
-(NSString *)testRequestWithStringA:(NSString *)a AndStrB:(NSString *)b;

@property (weak, nonatomic) IBOutlet UITextField *downloadAddress;
- (IBAction)doDownload:(id)sender;

@property (weak, nonatomic) IBOutlet UITextView *weatherTextView;
- (IBAction)getWeather:(id)sender;

@end
