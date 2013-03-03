//
//  BWViewController.m
//  BaroqueTest
//
//  Created by Mr.Xun on 13-3-3.
//  Copyright (c) 2013年 Mr.Xun. All rights reserved.
//

#import "BWViewController.h"

@interface BWViewController ()

@end

@implementation BWViewController
@synthesize answer;
@synthesize aNum;
@synthesize bNum;


-(IBAction) textfieldDoneEditing:(id)sender
{
    [sender resignFirstResponder];
}

- (IBAction) backgroundTap: (id)sender
{
    [aNum resignFirstResponder];
    [bNum resignFirstResponder];
}

//-(IBAction)buttonPressed:(id)sender
//{
//    NSString *aNumber = self.aNum.text;
//    NSString *bNumber = self.bNum.text;
//    int a = [aNumber intValue];
//    int b = [bNumber intValue];
//    NSString *ans = [NSString stringWithFormat:@"%d",a+b];
//    self.answer.text = ans;
//}

-(IBAction)buttonPressed:(id)sender
{
    NSString *aNumber = self.aNum.text;
    NSString *bNumber = self.bNum.text;
    self.answer.text = @"calculating...";
    NSString *test =[self testRequestWithStringA:aNumber AndStrB:bNumber];
    self.answer.text = test;
}


-(NSString *)testRequestWithStringA:(NSString *)a AndStrB:(NSString *)b;
{
//    NSString *requestString = [NSString stringWithFormat:@"http://baroque.sinaapp.com/add?a=1&b=2"];
    NSString *requestString = [NSString stringWithFormat:@"http://baroque.sinaapp.com/add?a=%@&b=%@",a,b];

    // 数据内容转换为UTF8编码，第二个参数为数据长度
    //    NSData *requestData = [NSData dataWithBytes:[requestString UTF8String] length:[requestString length]];
    // 请求的URL地址
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:requestString]];
    NSLog(@"%@\n",requestString);
    // 设置请求方式
    //[request setHTTPMethod:@"get"];
    // 设置请求内容
    //[request setHTTPBody:requestData];
    // 设置请求头声明
    [request setValue:@"text/xml" forHTTPHeaderField:@"Content-type"];
    // 执行请求
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    
    // 输出返回数据
    NSString *returnString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"%@", returnString);
    return returnString;
}

@end
