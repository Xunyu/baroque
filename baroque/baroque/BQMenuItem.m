//
//  BQMenuItem.m
//  baroque
//
//  Created by Sn Dev on 13-5-23.
//  Copyright (c) 2013年 Baroque. All rights reserved.
//

#import "BQMenuItem.h"

@implementation BQMenuItem
@synthesize foodID = _foodID,itemImageView = _itemImageView
    ,itemCount = _itemCount,itemPrice = _itemPrice,itemName = _itemName;

- (id)init {
    self = [super init];
    if (self){
        NSArray *xib = [[NSBundle mainBundle] loadNibNamed:@"BQMenuItem" owner:self options:nil];
        self = [xib objectAtIndex:0];
    }
    return self;
}

- (IBAction)itemPlusButtonPressed:(id)sender {
    self.itemCount.text = [BQItemCountAction itemCountPlusWithFoodID:self.foodID];
}

- (IBAction)itemMinusButtonPressed:(id)sender {
    self.itemCount.text = [BQItemCountAction itemCountMinusWithFoodID:self.foodID];
}
@end
