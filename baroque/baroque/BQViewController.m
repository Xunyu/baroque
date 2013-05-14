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
}
@end

@implementation BQViewController
@synthesize categoryTableView = _categoryTableView;
@synthesize dishGridView = _dishGridView;
@synthesize appSettingsViewController;
@synthesize menuInfo = _menuInfo,menuFoodType = _menuFoodType;

- (NSArray*)menuInfo
{
    NSFetchRequest *fetch = [[NSFetchRequest alloc]init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Bar_Menu" inManagedObjectContext:[BQCoreDataUtil sharedInstance].managedObjectContext];
    [fetch setEntity:entity];
    NSError *error = nil;
    NSArray *menu = [[BQCoreDataUtil sharedInstance].managedObjectContext executeFetchRequest:fetch error:&error];
    return menu;
}
- (NSArray*)menuFoodType
{
    NSMutableArray *type = [[NSMutableArray alloc]init];
    if (self.menuInfo != nil){
        for (Bar_Menu *menuItem in self.menuInfo) {
            if (![menuItem.foodType isEqualToString:@""]&& menuItem.foodType != nil) {
                [type addObject:menuItem.foodType];
            }
        }
    }
    NSMutableArray *unRepeatType = [[NSMutableArray alloc]init];
    if (type !=nil){
        for (unsigned int i = 0; i < [type count]; i++) {
            if (![unRepeatType containsObject:[type objectAtIndex:i]]){
                [unRepeatType addObject:[type objectAtIndex:i]];
            }
        }
    }
    return unRepeatType;
}
- (void)syncMenuInfoFinished
{
    [self.categoryTableView reloadData];
    [self.dishGridView reloadData];
}
#pragma mark - ViewControllres LiftCycles
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(syncMenuInfoFinished) name:@"syncMenuInfoFinished" object:nil];
    

}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
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
    return [self.menuFoodType count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"dishCategoryCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = [self.menuFoodType objectAtIndex:[indexPath row]];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    return cell;
}

#pragma mark - GMGridView DataSource
- (NSInteger)numberOfItemsInGMGridView:(GMGridView *)gridView
{
    return [self.menuInfo count];
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
    NSString *imageURL = [[self.menuInfo objectAtIndex:index] picUrl];
    [itemImageView setImageWithURL:[NSURL URLWithString:imageURL]];
    [itemView addSubview:itemImageView];
    UILabel *itemName = [[UILabel alloc]initWithFrame:CGRectMake(12, 163, 85, 21)];
    itemName.text = [NSString stringWithFormat:@"%@",[[self.menuInfo objectAtIndex:index] foodName]];
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
    [detailPage setMenuInfoCount:[self.menuInfo count]];
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
        [[BQSyncMenuInfo sharedInstance]beginSync];
    }
}
@end
