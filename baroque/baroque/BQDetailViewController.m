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
    UIPopoverController *popover;
    NSArray *tasteInfo;
}
@end

@implementation BQDetailViewController
@synthesize dishName = _dishName,menuInfo = _menuInfo,categoryName = _categoryName,vcArray = _vcArray;
- (NSArray*)menuInfo
{
    if (_menuInfo == nil){
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"foodType = %@",self.categoryName];
        _menuInfo = [BQCoreDataUtil fetchDataWithEntity:@"Bar_Menu" andWithPredicate:predicate];
    }
    return _menuInfo;
}
+ (BQDetailViewController *)detailViewControllerForPageIndex:(NSUInteger)pageIndex withPageCount:(NSUInteger)pageCount withCategoryName:(NSString *)categoryName
{
    if (pageIndex<pageCount){
        return [[self alloc] initWithPageIndex:pageIndex withCategoryName:categoryName];
    }
    return nil;
}
- (NSInteger)pageIndex
{
    return _pageIndex;
}
- (id)initWithPageIndex:(NSInteger)pageIndex withCategoryName:(NSString*)categoryName
{
    self = [super initWithNibName:nil bundle:nil];
    if (self)
    {
        _pageIndex = pageIndex;
        _categoryName = categoryName;
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if ([[[self.menuInfo objectAtIndex:_pageIndex]tastyType]isEqualToString:@""]){
        self.dishTaste.hidden = YES;
        self.dishTasteButton.hidden = YES;
    }
    else{
        tasteInfo = [[NSArray alloc]initWithObjects:[[self.menuInfo objectAtIndex:_pageIndex]tastyType], nil];
        self.dishTaste.text = [tasteInfo objectAtIndex:0];
    }
    self.dishCookWay.hidden = YES;
    self.dishCookWayButton.hidden = YES;
    self.dishName.text = [NSString stringWithFormat:@"%@",[[self.menuInfo objectAtIndex:_pageIndex]foodName]];
    self.dishUnitPrice.text = [NSString stringWithFormat:@"单价 %@￥",[[self.menuInfo objectAtIndex:_pageIndex]price]];
    self.dishMount.text = [BQItemCountAction getItemCountWithFoodID:[[self.menuInfo objectAtIndex:_pageIndex]foodID]];
    NSString *picUrl = [[self.menuInfo objectAtIndex:_pageIndex] picUrl];
    picUrl = [picUrl stringByReplacingOccurrencesOfString:@"_small" withString:@""];
    [self.dishImageView setImageWithURL:[NSURL URLWithString:picUrl]];
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
    [self setDishCookWayButton:nil];
    [self setDishTasteButton:nil];
    [super viewDidUnload];
}
- (IBAction)popOverButtonTouched:(id)sender {
    NSLog(@"sender: %@, tag = %d", sender, [sender tag]);
    if (!self.vcArray)
    {
        self.vcArray = [[NSArray alloc] initWithObjects:
                      [[BQOrderCookWayViewController alloc]initWithStyle:UITableViewStylePlain],
                      [[BQOrderTasteViewController alloc]initWithStyle:UITableViewStylePlain],nil];
    }
    UIViewController *vc = [self.vcArray objectAtIndex:[sender tag]];
    popover = [[UIPopoverController alloc]initWithContentViewController:vc];
    popover.popoverContentSize = CGSizeMake(200, 300);
    [popover presentPopoverFromRect:[sender frame] inView:self.view permittedArrowDirections:UIPopoverArrowDirectionRight animated:YES];
}

- (IBAction)backButtonTouched:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)dishMountPlus:(id)sender {
    self.dishMount.text = [BQItemCountAction itemCountPlusWithFoodID:[[self.menuInfo objectAtIndex:_pageIndex]foodID]];
}

- (IBAction)dishMountMinus:(id)sender {
    self.dishMount.text = [BQItemCountAction itemCountMinusWithFoodID:[[self.menuInfo objectAtIndex:_pageIndex]foodID]];

}
@end
