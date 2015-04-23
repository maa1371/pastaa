//
//  CommentCell.h
//  pastaa
//
//  Created by Mohammad Hasan Ansari on 12/24/1393 AP.
//  Copyright (c) 1393 AP Reza Sazegarnezhad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextView *commentMessage;
@property (weak, nonatomic) IBOutlet UILabel *userName;


@end
