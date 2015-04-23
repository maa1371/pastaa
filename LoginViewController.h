//
//  LoginViewController.h
//  pastaa
//
//  Created by Amin on 3/2/15.
//  Copyright (c) 2015 Reza Sazegarnezhad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "MBProgressHUD.h"
#import "ILTranslucentView.h"

@interface LoginViewController : UIViewController<UITextFieldDelegate>
{
    UIView* regView;
    UIView* logView;
    UIVisualEffectView *visualEffectView;
    UITextField * userNameTextField;
    UITextField * passwordTextField;
    UITextField * userEmailTextField;
    UITextField * loginUsernameTextField;
    UITextField * loginPasswordTextField;
    MBProgressHUD *hud;
    NSArray* backPick;
    int i;
    
}

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;
@property (weak, nonatomic) IBOutlet UIImageView *pageTitle;
@property (weak, nonatomic) IBOutlet UIButton *loginOutlet;
@property (weak, nonatomic) IBOutlet UIButton *registerOutlet;
@property (weak, nonatomic) IBOutlet UIImageView *loginBackgroundImage;




@end
