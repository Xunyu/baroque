//
//  BQDetailViewController.m
//  pageViewController
//
//  Created by Sn Dev on 13-4-17.
//  Copyright (c) 2013年 Baroque. All rights reserved.
//

#import "BQDetailViewController.h"

@interface BQDetailViewController ()
{
    NSUInteger _pageIndex;
}
@end

@implementation BQDetailViewController
@synthesize number = _number;
+ (BQDetailViewController*)detailViewControllerForPageIndex:(NSUInteger)pageIndex
{
    return [[self alloc]initWithPageIndex:pageIndex];
}

- (id)initWithPageIndex:(NSInteger)pageIndex
{
    self = [super initWithNibName:nil bundle:nil];
    if (self){
        _pageIndex = pageIndex;
    }
    return self;
}
- (NSInteger)pageIndex
{
    return _pageIndex;
}
- (void)viewWillAppear:(BOOL)animated
{
    self.number.text = [NSString stringWithFormat:@"%d",self.pageIndex];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
