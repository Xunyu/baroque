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
    NSString *selectedCategoryName;
}
@end

@implementation BQViewController
@synthesize categoryTableView = _categoryTableView;
@synthesize appSettingsViewController;
@synthesize menuInfo = _menuInfo,menuFoodType = _menuFoodType,categoryMenuInfo = _categoryMenuInfo;


//从NSCore获取菜单
- (NSArray*)menuInfo
{
    NSArray *barMenu = [BQCoreDataUtil fetchDataWithEntity:@"Bar_Menu"];
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"foodID" ascending:YES];
    barMenu = [barMenu sortedArrayUsingDescriptors:[NSArray arrayWithObjects:descriptor,nil]];
    return barMenu;
}

//从已有菜单中提取foodType字段add到menuFoodType，之后作为索引(去重)

- (NSArray*)menuFoodType
{
    NSMutableArray *type = [[NSMutableArray alloc]init];
    if (self.menuInfo != nil){
        for (Bar_Menu *menuItem in self.menuInfo) {
            if ([menuItem.foodType length] && ![type containsObject:menuItem.foodType]) {
                [type addObject:menuItem.foodType];
            }
        }
    }
    _menuFoodType = type;
    return _menuFoodType;
}
- (void)reloadData
{
    [self.categoryTableView reloadData];
//    [self.dishGridView reloadData];
    if ([self.menuFoodType count]>0){
        [self tableView:self.categoryTableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
    }
}
#pragma mark - ViewControllres LiftCycles
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadData) name:@"syncMenuInfoFinished" object:nil];
    [self reloadData];

}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setCategoryTableView:nil];
    [super viewDidUnload];
}
#pragma mark - UITableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.categoryTableView){
        selectedCategoryName = [self.menuFoodType objectAtIndex:[indexPath row]];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"foodType = %@",selectedCategoryName];
        self.categoryMenuInfo = [BQCoreDataUtil fetchDataWithEntity:@"Bar_Menu" andWithPredicate:predicate];
        PSStackedViewController *stackController = XAppDelegate.stackController;

        BQMenuGridViewController *menuGridVC = [[BQMenuGridViewController alloc]init];
        [menuGridVC setCategoryMenuInfo:self.categoryMenuInfo];
        [menuGridVC setSelectedCategoryName:selectedCategoryName];
        [[self stackController] pushViewController:menuGridVC fromViewController:self animated:YES];
        [stackController popToRootViewControllerAnimated:YES];
        [stackController pushViewController:menuGridVC animated:YES];
    }
//    [self.dishGridView reloadData];
//    [self.dishGridView scrollToObjectAtIndex:0 atScrollPosition:GMGridViewScrollPositionTop animated:YES];
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
    cell.textLabel.font = [UIFont boldSystemFontOfSize:40.0f ];
    cell.textLabel.textAlignment = UITextAlignmentCenter;
    return cell;
}

#pragma mark - ViewControllers Actions
- (IBAction)settingButtonTapped:(id)sender {
    self.appSettingsViewController.showCreditsFooter = FALSE;
//    self.appSettingsViewController.showDoneButton = YES;
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:self.appSettingsViewController];
    [nav setModalPresentationStyle:UIModalPresentationFormSheet];
    [nav setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    nav.navigationBar.barStyle = UIBarStyleBlack;
    [XAppDelegate.stackController popToRootViewControllerAnimated:NO];
    [XAppDelegate.stackController pushViewController:nav animated:YES];
//    [self presentModalViewController:nav animated:YES];
//    nav.view.superview.autoresizingMask =
//    UIViewAutoresizingFlexibleTopMargin |
//    UIViewAutoresizingFlexibleBottomMargin;
//    nav.view.superview.frame = CGRectMake(
//                                          [UIScreen mainScreen].applicationFrame.size.height/2-150,
//                                          [UIScreen mainScreen].applicationFrame.size.width/2-200,
//                                          300.0f,
//                                          400.0f
//                                          );
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
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    if ([segue.identifier isEqualToString:@"orderSegue"]){
//        BQOrderViewController *vc = segue.destinationViewController;
//        [vc setMenuInfo:self.menuInfo];
//    }
//}
@end
