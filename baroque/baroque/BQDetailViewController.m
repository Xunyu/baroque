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
@synthesize dishName = _dishName,menuInfo = _menuInfo;
- (NSArray*)menuInfo
{
    if (_menuInfo == nil){
        NSFetchRequest *fetch = [[NSFetchRequest alloc]init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Bar_Menu" inManagedObjectContext:[BQCoreDataUtil sharedInstance].managedObjectContext];
        [fetch setEntity:entity];
        NSError *error = nil;
        _menuInfo = [[BQCoreDataUtil sharedInstance].managedObjectContext executeFetchRequest:fetch error:&error];
    }
    return _menuInfo;
}
+ (BQDetailViewController *)detailViewControllerForPageIndex:(NSUInteger)pageIndex withPageCount:(NSUInteger)pageCount
{
    if (pageIndex<pageCount){
        return [[self alloc] initWithPageIndex:pageIndex];
    }
    return nil;
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
- (IBAction)dishTasteEditButtonTouched:(id)sender {
    BQOrderTasteViewController *vc = [[BQOrderTasteViewController alloc]initWithStyle:UITableViewStylePlain];
    [vc setTasteInfo:tasteInfo];
    popover = [[UIPopoverController alloc]initWithContentViewController:vc];
    popover.popoverContentSize = CGSizeMake(200, 300);
    [popover presentPopoverFromRect:[sender frame] inView:self.view permittedArrowDirections:UIPopoverArrowDirectionDown animated:YES];
}

- (IBAction)dishCookWayEditButtonTouched:(id)sender {
    BQOrderCookWayViewController *vc = [[BQOrderCookWayViewController alloc]initWithStyle:UITableViewStylePlain];
    popover = [[UIPopoverController alloc]initWithContentViewController:vc];
    popover.popoverContentSize = CGSizeMake(200, 300);
    [popover presentPopoverFromRect:[sender frame] inView:self.view permittedArrowDirections:UIPopoverArrowDirectionDown animated:YES];
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
