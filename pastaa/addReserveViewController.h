//
//  addReserveViewController.h
//  pastaa
//
//  Created by Helia Taghavi on 4/8/15.
//  Copyright (c) 2015 Reza Sazegarnezhad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface addReserveViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *countLabel;
@property (weak, nonatomic) IBOutlet UIButton *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *weekdayLabel;
@property PFObject* ResturantObject;

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@end
