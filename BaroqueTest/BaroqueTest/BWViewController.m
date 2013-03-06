//
//  BWViewController.m
//  BaroqueTest
//
//  Created by Mr.Xun on 13-3-3.
//  Copyright (c) 2013年 Mr.Xun. All rights reserved.
//

#import "BWViewController.h"

@interface BWViewController ()
{
    ASIHTTPRequest *downloadRequest,*weatherRequest;
}
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
    [self.downloadAddress resignFirstResponder];
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

- (IBAction)doDownload:(id)sender {
    downloadRequest = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:self.downloadAddress.text]];
    [downloadRequest setDelegate:self];
    [downloadRequest startAsynchronous];
    
}
- (IBAction)getWeather:(id)sender {
    weatherRequest = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:@"http://m.weather.com.cn/data/101250101.html"]];
    [weatherRequest setDelegate:self];
    [weatherRequest startAsynchronous];
}

#pragma mark - ASIHTTPRequest Delegate
- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSString *responseString = [request responseString];
    NSLog(@"%@",responseString);
    NSData *responseData = [request responseData];
    if (request == downloadRequest){
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentDirectory = [paths lastObject];
        NSString *dataPath = [documentDirectory stringByAppendingPathComponent:@"downloadthing"];
        [responseData writeToFile:dataPath atomically:NO];
    }
    else if (request == weatherRequest){
        NSData *response = [request responseData];
        NSError *error;
        NSDictionary *weatherDic = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
        NSDictionary *weatherInfo = [weatherDic objectForKey:@"weatherinfo"];
        self.weatherTextView.text = [NSString stringWithFormat:@"今天是 %@  %@  %@  的天气状况是：%@  %@ ",[weatherInfo objectForKey:@"date_y"],[weatherInfo objectForKey:@"week"],[weatherInfo objectForKey:@"city"], [weatherInfo objectForKey:@"weather1"], [weatherInfo objectForKey:@"temp1"]];
    }
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
    NSLog(@"%@",error);
}



@end
