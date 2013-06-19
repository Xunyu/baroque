//
//  BQMenuGridViewController.m
//  baroque
//
//  Created by Sn Dev on 13-6-19.
//  Copyright (c) 2013年 Baroque. All rights reserved.
//

#import "BQMenuGridViewController.h"

@interface BQMenuGridViewController ()

@end

@implementation BQMenuGridViewController
@synthesize dishGridView = _dishGridView,categoryMenuInfo = _categoryMenuInfo;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.dishGridView.backgroundColor = [UIColor clearColor];
    self.dishGridView.layoutStrategy = [GMGridViewLayoutStrategyFactory strategyFromType:GMGridViewLayoutVertical];
    self.dishGridView.minEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    self.dishGridView.clipsToBounds = YES;
    self.dishGridView.backgroundColor = [UIColor lightGrayColor];
    self.dishGridView.dataSource = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - GMGridView DataSource
- (NSInteger)numberOfItemsInGMGridView:(GMGridView *)gridView
{
    return [self.categoryMenuInfo count];
}
- (CGSize)GMGridView:(GMGridView *)gridView sizeForItemsInInterfaceOrientation:(UIInterfaceOrientation)orientation
{
    return CGSizeMake(260 , 205);
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
        [view.layer setMasksToBounds:YES];
        view.layer.cornerRadius = 8;
        view.layer.shadowColor = [UIColor blackColor].CGColor;
        view.layer.shadowOffset = CGSizeMake(5, 5);
        view.layer.shadowPath = [UIBezierPath bezierPathWithRect:view.bounds].CGPath;
        view.layer.shadowRadius = 8;
        
        cell.contentView = view;
    }
    [[cell.contentView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    BQMenuItem *itemView = [[BQMenuItem alloc]init];
    [itemView setFoodID:[[self.categoryMenuInfo objectAtIndex:index]foodID]];
    [[itemView itemCount]setText:[BQItemCountAction getItemCountWithFoodID:[[self.categoryMenuInfo objectAtIndex:index]foodID]]];
    [[itemView itemPrice]setText:[NSString stringWithFormat:@"%@￥/份",[[self.categoryMenuInfo objectAtIndex:index] price]]];
    NSString *imageURL = [[self.categoryMenuInfo objectAtIndex:index] picUrl];
    [[itemView itemImageView]setImageWithURL:[NSURL URLWithString:imageURL]];
    [[itemView itemName]setText:[[self.categoryMenuInfo objectAtIndex:index]foodName]];
    [cell.contentView addSubview:itemView];
    
    return cell;
}
#pragma mark - GMGridView Delegate
- (void)GMGridView:(GMGridView *)gridView didTapOnItemAtIndex:(NSInteger)position{
    
    GMGridViewCell *cell = [gridView cellForItemAtIndex:position];
    [gridView scrollToObjectAtIndex:position atScrollPosition:GMGridViewScrollPositionMiddle animated:NO];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 576, 400)];
    [view setBackgroundColor:[UIColor blackColor]];
    JWFolders *folder = [JWFolders folder];
    folder.contentView = view;
    folder.containerView = self.view;
    folder.position = CGPointMake(cell.frame.origin.x+130, cell.frame.origin.y+215);
    folder.direction = JWFoldersOpenDirectionDown;
    folder.contentBackgroundColor = [UIColor whiteColor];
    folder.shadowsEnabled = YES;
    folder.darkensBackground = NO;
    folder.showsNotch = YES;
    [folder open];
    
    
//    BQDetailPageViewController *detailPage = [[BQDetailPageViewController alloc]init];
//    [detailPage setCurrentDishID:position];
//    [detailPage setMenuInfoCount:[self.categoryMenuInfo count]];
//    [detailPage setCategoryName:self.selectedCategoryName];
//    [XAppDelegate.stackController pushViewController:detailPage fromViewController:self animated:YES];
//    [detailPage setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
//    [self presentModalViewController:detailPage animated:YES];
}

@end
