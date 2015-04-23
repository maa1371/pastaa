//
//  TemplateCell.m
//  pastaa
//
//  Created by Mohammad Hasan Ansari on 12/23/1393 AP.
//  Copyright (c) 1393 AP Reza Sazegarnezhad. All rights reserved.
//

#import "TemplateCell.h"

@implementation TemplateCell

- (void)awakeFromNib {
    self.foodImage.layer.cornerRadius=self.foodImage.frame.size.width/2;
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
