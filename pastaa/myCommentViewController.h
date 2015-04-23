//
//  myCommentViewController.h
//  pastaa
//
//  Created by Helia Taghavi on 4/21/15.
//  Copyright (c) 2015 Reza Sazegarnezhad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "CommentCell.h"
@interface myCommentViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;
@property (weak, nonatomic) IBOutlet UITableView *commentTable;
@property PFObject* ResturantObject;
@property NSMutableArray * messageArray;
@property NSMutableArray * userNameArray;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomSpace;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewHeight;
@property (weak, nonatomic) IBOutlet UIView *myView;
@property (weak, nonatomic) IBOutlet UITextView *iView;
@property (weak, nonatomic) IBOutlet UIButton *sendBtn;

@end
