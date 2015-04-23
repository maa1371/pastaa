//
//  reserveCell.h
//  pastaa
//
//  Created by Helia Taghavi on 4/12/15.
//  Copyright (c) 2015 Reza Sazegarnezhad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface reserveCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *resturantName;
@property (weak, nonatomic) IBOutlet UILabel *reserveDate;
@property (weak, nonatomic) IBOutlet UILabel *reserveHour;

@property (weak, nonatomic) IBOutlet UILabel *reserveCount;
@property (weak, nonatomic) IBOutlet UILabel *reserveCode;
@end
