//
//  BQViewController.m
//  baroque
//
//  Created by Sn Dev on 13-4-8.
//  Copyright (c) 2013年 Baroque. All rights reserved.
//

#import "BQViewController.h"

@interface BQViewController ()
{
    NSArray *categoryArray;
}
@end

@implementation BQViewController
@synthesize categoryTableView = _categoryTableView;
@synthesize dishGridView = _dishGridView;
@synthesize appSettingsViewController;


#pragma mark - ViewControllres LiftCycles
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    categoryArray = [[NSArray alloc]initWithObjects:@"热门菜",@"热门菜",@"热门菜",@"热门菜", nil];
    self.dishGridView.backgroundColor = [UIColor clearColor];
    self.dishGridView.layoutStrategy = [GMGridViewLayoutStrategyFactory strategyFromType:GMGridViewLayoutHorizontalPagedLTR];
    self.dishGridView.minEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    self.dishGridView.clipsToBounds = YES;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setDishGridView:nil];
    [self setCategoryTableView:nil];
    [super viewDidUnload];
}
#pragma mark - UITableView Datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [categoryArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"dishCategoryCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = [categoryArray objectAtIndex:[indexPath row]];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    return cell;
}

#pragma mark - GMGridView DataSource
- (NSInteger)numberOfItemsInGMGridView:(GMGridView *)gridView
{
    return 25;
}
- (CGSize)GMGridView:(GMGridView *)gridView sizeForItemsInInterfaceOrientation:(UIInterfaceOrientation)orientation
{
    return CGSizeMake(230, 200);
}
- (GMGridViewCell *)GMGridView:(GMGridView *)gridView cellForItemAtIndex:(NSInteger)index
{
    CGSize size = [self GMGridView:gridView sizeForItemsInInterfaceOrientation:[[UIApplication sharedApplication] statusBarOrientation]];
    
    GMGridViewCell *cell = [gridView dequeueReusableCell];
    
    if (!cell)
    {
        cell = [[GMGridViewCell alloc] init];
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
        view.backgroundColor = [UIColor lightGrayColor];
        view.layer.cornerRadius = 8;
        view.layer.shadowColor = [UIColor blackColor].CGColor;
        view.layer.shadowOffset = CGSizeMake(5, 5);
        view.layer.shadowPath = [UIBezierPath bezierPathWithRect:view.bounds].CGPath;
        view.layer.shadowRadius = 8;
        
        cell.contentView = view;
    }
    
    [[cell.contentView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    UIView *itemView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 230, 200)];
    UIImageView *itemImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 230, 150)];
    itemImageView.backgroundColor = [UIColor blackColor];
    [itemView addSubview:itemImageView];
    UILabel *itemName = [[UILabel alloc]initWithFrame:CGRectMake(12, 163, 85, 21)];
    itemName.text = [NSString stringWithFormat:@"%@ %d",@"我是菜",index];
    itemName.backgroundColor = [UIColor clearColor];
    [itemView addSubview:itemName];
    UILabel *itemCount = [[UILabel alloc]initWithFrame:CGRectMake(145, 163, 34, 21)];
    itemCount.text = @"1";
    itemCount.textAlignment = UITextAlignmentCenter;
    itemCount.backgroundColor = [UIColor clearColor];
    [itemView addSubview:itemCount];
    UIButton *itemMinusButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    itemMinusButton.frame = CGRectMake(105, 158, 32, 32);
    itemMinusButton.titleLabel.text = @"-";
    [itemView addSubview:itemMinusButton];
    UIButton *itemPlusButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    itemPlusButton.frame = CGRectMake(187, 158, 32, 32);
    itemPlusButton.titleLabel.text = @"+";
    [itemView addSubview:itemPlusButton];
    [cell.contentView addSubview:itemView];
//    UILabel *label = [[UILabel alloc] initWithFrame:cell.contentView.bounds];
//    label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//    label.text = [NSString stringWithFormat:@"%@ %d",@"我是菜",index];
//    label.textAlignment = UITextAlignmentCenter;
//    label.backgroundColor = [UIColor clearColor];
//    label.textColor = [UIColor blackColor];
//    label.highlightedTextColor = [UIColor whiteColor];
//    label.font = [UIFont boldSystemFontOfSize:20];
//    [cell.contentView addSubview:label];
    
    return cell;
}
#pragma mark - GMGridView Delegate
- (void)GMGridView:(GMGridView *)gridView didTapOnItemAtIndex:(NSInteger)position{
    BQDetailPageViewController *detailPage = [[BQDetailPageViewController alloc]init];
    [detailPage setCurrentDishID:position];
    [detailPage setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    [self presentModalViewController:detailPage animated:YES];
}
#pragma mark - ViewControllers Actions
- (IBAction)settingButtonTapped:(id)sender {
    self.appSettingsViewController.showCreditsFooter = FALSE;
    self.appSettingsViewController.showDoneButton = YES;
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:self.appSettingsViewController];
    [nav setModalPresentationStyle:UIModalPresentationFormSheet];
    [nav setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    nav.navigationBar.barStyle = UIBarStyleBlack;
    [self presentModalViewController:nav animated:YES];
    nav.view.superview.autoresizingMask =
    UIViewAutoresizingFlexibleTopMargin |
    UIViewAutoresizingFlexibleBottomMargin;
    nav.view.superview.frame = CGRectMake(
                                          [UIScreen mainScreen].applicationFrame.size.height/2-150,
                                          [UIScreen mainScreen].applicationFrame.size.width/2-200,
                                          300.0f,
                                          400.0f
                                          );
}
#pragma makr - InAppSettingKit Delegate
- (IASKAppSettingsViewController*)appSettingsViewController
{
    if (!appSettingsViewController){
        appSettingsViewController = [[IASKAppSettingsViewController alloc]init];
        appSettingsViewController.delegate = self;
        appSettingsViewController.file = @"Root";
        [appSettingsViewController setTitle:NSLocalizedString(@"settings", nil)];
    }
    return appSettingsViewController;
    
}
- (void)settingsViewControllerDidEnd:(IASKAppSettingsViewController*)sender
{
    [self.appSettingsViewController dismissModalViewControllerAnimated:YES];
}

- (void)settingsViewController:(IASKAppSettingsViewController *)sender buttonTappedForSpecifier:(IASKSpecifier *)specifier
{
    if ([specifier.key isEqualToString:@"SyncMenu"]){
        
    }
}
@end
