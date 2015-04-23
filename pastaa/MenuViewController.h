//
//  MenuViewController.h
//  pastaa
//
//  Created by Mohammad Hasan Ansari on 12/23/1393 AP.
//  Copyright (c) 1393 AP Reza Sazegarnezhad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
@interface MenuViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property PFObject* ResturantObject;
@property NSMutableArray* nameArray;
@property NSMutableArray* imageArray;
@property NSMutableArray* ingredientArray;
@property NSMutableArray* priceArray;
@property NSMutableArray* categoryArray;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;


@property (weak, nonatomic) IBOutlet UITableView *menuTable;

@end
