//
//  userViewController.h
//  pastaa
//
//  Created by Helia Taghavi on 4/12/15.
//  Copyright (c) 2015 Reza Sazegarnezhad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "reserveCell.h"
@interface userViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property NSMutableArray* reservedResturants;
//@property NSMutableArray* names;
@property NSMutableArray* hours;
@property NSMutableArray* dates;
@property NSMutableArray* rCount;
@property NSMutableArray* resturantName;
//@property NSMutableArray* restID;
@property NSMutableArray* reserveID;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;

@property (weak, nonatomic) IBOutlet UIView *myReserveLabel;

@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UITableView *reserveTable;
@end
