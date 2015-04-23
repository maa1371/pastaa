//
//  CommentViewController.h
//  pastaa
//
//  Created by Mohammad Hasan Ansari on 12/24/1393 AP.
//  Copyright (c) 1393 AP Reza Sazegarnezhad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "CommentCell.h"

@interface CommentViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;
@property (weak, nonatomic) IBOutlet UITableView *commentTable;
@property PFObject* ResturantObject;
@property NSMutableArray * messageArray;
@property NSMutableArray * userNameArray;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *keyboardHeight;

@property (weak, nonatomic) IBOutlet UIView *iView;

@property (weak, nonatomic) IBOutlet UITextView *chatInput;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *chatInputHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *iViewHeight;

@end
