//
//  CommentCell.m
//  pastaa
//
//  Created by Mohammad Hasan Ansari on 12/24/1393 AP.
//  Copyright (c) 1393 AP Reza Sazegarnezhad. All rights reserved.
//

#import "CommentCell.h"

@implementation CommentCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.commentMessage.editable=NO;
    // Configure the view for the selected state
}

@end
