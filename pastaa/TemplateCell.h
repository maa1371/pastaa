//
//  TemplateCell.h
//  pastaa
//
//  Created by Mohammad Hasan Ansari on 12/23/1393 AP.
//  Copyright (c) 1393 AP Reza Sazegarnezhad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TemplateCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *foodImage;
@property (weak, nonatomic) IBOutlet UILabel *foodName;
@property (weak, nonatomic) IBOutlet UILabel *foodIngredient;

@property (weak, nonatomic) IBOutlet UILabel *foodPrice;
@end
