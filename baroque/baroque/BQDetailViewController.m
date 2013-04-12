//
//  BQDetailViewController.m
//  baroque
//
//  Created by Sn Dev on 13-4-12.
//  Copyright (c) 2013年 Baroque. All rights reserved.
//

#import "BQDetailViewController.h"

@interface BQDetailViewController ()
{
    NSUInteger _pageIndex;
}
@end

@implementation BQDetailViewController

+ (BQDetailViewController *)detailViewControllerForPageIndex:(NSUInteger)pageIndex
{
    return [[self alloc] initWithPageIndex:pageIndex];
}
- (NSInteger)pageIndex
{
    return _pageIndex;
}
- (id)initWithPageIndex:(NSInteger)pageIndex
{
    self = [super initWithNibName:nil bundle:nil];
    if (self)
    {
        _pageIndex = pageIndex;
    }
    return self;
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

- (void)viewDidUnload {
    [self setDishImageView:nil];
    [self setDishName:nil];
    [self setDishUnitPrice:nil];
    [self setDishDescription:nil];
    [self setDishMount:nil];
    [self setDishCookWay:nil];
    [self setDishTaste:nil];
    [super viewDidUnload];
}
- (IBAction)dishTasteEditButtonTouched:(id)sender {
}

- (IBAction)dishCookWayEditButtonTouched:(id)sender {
}

- (IBAction)backButtonTouched:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}
@end
