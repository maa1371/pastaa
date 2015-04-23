//
//  searchFilterView.h
//  pastaa
//
//  Created by Helia Taghavi on 4/5/15.
//  Copyright (c) 2015 Reza Sazegarnezhad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface searchFilterView : UIView
@property (weak, nonatomic) IBOutlet UITextField *resturantName;
@property (weak, nonatomic) IBOutlet UIButton *resturantDistance;
@property (weak, nonatomic) IBOutlet UITextField *resturantType;
@property (weak, nonatomic) IBOutlet UITextField *resturantCostLevel;
@property (weak, nonatomic) IBOutlet UITextField *resturantDiscount;
@property (weak, nonatomic) IBOutlet UIButton *searchResturantListButton;

@property (weak, nonatomic) IBOutlet UIButton *increaseDistanceBtn;

@property (weak, nonatomic) IBOutlet UIButton *decreaseDistanceBtn;
@end
