//
//  LoginViewController.m
//  pastaa
//
//  Created by Amin on 3/2/15.
//  Copyright (c) 2015 Reza Sazegarnezhad. All rights reserved.
//

#import "LoginViewController.h"
#import "registerView.h"
#import "loginView.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
//    [self.loginBackgroundImage setImageToBlur:self.loginBackgroundImage.image
//                        blurRadius:kLBBlurredImageDefaultBlurRadius
//                   completionBlock:^(){
//                       NSLog(@"The blurred image has been set");
//                   }];
//    

//    UIVisualEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
//    visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
//    [visualEffectView setFrame:self.view.bounds];
//    [_backgroundImage addSubview:visualEffectView];
//    
    ILTranslucentView *translucentView = [[ILTranslucentView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:translucentView]; //that's it :)
    
    //optional:
    translucentView.translucentAlpha = 0.3;
    translucentView.translucentStyle = UIBarStyleDefault;
    translucentView.translucentTintColor = [UIColor clearColor];
    translucentView.backgroundColor = [UIColor clearColor];
    [self.view sendSubviewToBack:translucentView];
    [self.view sendSubviewToBack:self.backgroundImage];
    i=0;
    backPick=[[NSArray alloc]initWithObjects:[UIImage imageNamed:@"login-page-back1.jpg"], [UIImage imageNamed:@"login-page-back2.jpg"], [UIImage imageNamed:@"login-page-back3.jpg"], nil];
    [NSTimer scheduledTimerWithTimeInterval:4 target:self selector:@selector(changeBackPic) userInfo:nil repeats:YES];

    
    
    
    
    NSArray * regObjects = [[NSBundle mainBundle] loadNibNamed:@"registerView" owner:self options:nil];
    
    
    
    for(id currentObject in regObjects)
    {
        if([currentObject isKindOfClass:[UIView class]])
        {
            regView=(registerView*)currentObject;
            [((registerView*)regView).registerBtn addTarget:self action:@selector(registerAction:) forControlEvents:UIControlEventTouchUpInside];
            [((registerView*)regView).backBtn addTarget:self action:@selector(registerBackAction:) forControlEvents:UIControlEventTouchUpInside];
            
            userNameTextField= ((registerView*)regView).userNameTextField;
            passwordTextField= ((registerView*)regView).passwordTextField;
            userEmailTextField= ((registerView*)regView).userEmailTextField;
            
        
        }
        
    }
    NSArray * logObjects = [[NSBundle mainBundle] loadNibNamed:@"loginView" owner:self options:nil];
    
    
    
    for(id currentObject in logObjects)
    {
        if([currentObject isKindOfClass:[UIView class]])
        {
            logView=(loginView*)currentObject;
            [((loginView*)logView).loginBtn addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
            [((loginView*)logView).backBtn addTarget:self action:@selector(loginBackAction:) forControlEvents:UIControlEventTouchUpInside];
            
            loginUsernameTextField=((loginView*)logView).usernameTextField;
            loginPasswordTextField=((loginView*)logView).passwordTextField;
       
        }
        
        
    }
    userNameTextField.delegate=self;
    passwordTextField.delegate=self;
    userEmailTextField.delegate=self;
    loginUsernameTextField.delegate=self;
    loginPasswordTextField.delegate=self;
    
    regView.frame=self.view.frame;
    regView.alpha=0;
    [self.view addSubview:regView];
    [self.view bringSubviewToFront:regView];
    logView.frame=self.view.frame;
    logView.alpha=0;
    [self.view addSubview:logView];
    [self.view bringSubviewToFront:logView];
    // Do any additional setup after loading the view.
    
   

}

-(void)viewDidAppear:(BOOL)animated{

    [self firstLogin];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)registerButtonClicked:(id)sender {
    [UIView animateWithDuration:0.3 animations:^{
        regView.alpha=1;
        self.pageTitle.alpha=0;
        self.registerOutlet.alpha=0;
        self.loginOutlet.alpha=0;
        

        
        CGFloat currentScale = self.view.frame.size.width / self.view.frame.size.height;
        CGFloat newScale = currentScale * 2;
        
        
        CGAffineTransform iTransform = CGAffineTransformMakeScale(newScale, newScale);
        _loginBackgroundImage.transform = iTransform;
        

    }];
    

}
- (IBAction)loginButtonPressed:(id)sender {
    [UIView animateWithDuration:0.3 animations:^{
        logView.alpha=1;
        self.pageTitle.alpha=0;
        self.registerOutlet.alpha=0;
        self.loginOutlet.alpha=0;
      
        CGFloat currentScale = self.view.frame.size.width / self.view.frame.size.height;
        CGFloat newScale = currentScale * 2;
        
        
        CGAffineTransform iTransform = CGAffineTransformMakeScale(newScale, newScale);
        _loginBackgroundImage.transform = iTransform;
        
        
   //     visualEffectView.alpha=1;
        
        
    }];
}
-(void)loginBackAction:(UIButton*)sender
{
    [UIView animateWithDuration:0.3 animations:^{
        logView.alpha=0;
        self.pageTitle.alpha=1;
        self.registerOutlet.alpha=1;
        self.loginOutlet.alpha=1;
        
        CGFloat newScale = 1;
        
        
        CGAffineTransform iTransform = CGAffineTransformMakeScale(newScale, newScale);
        _loginBackgroundImage.transform = iTransform;
       
        [loginUsernameTextField resignFirstResponder];
        [loginPasswordTextField resignFirstResponder];
     //   visualEffectView.alpha=0;

    }];

    
}
-(void)registerAction:(UIButton*)sender{
 
    
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"دریافت اطلاعات ...";
    [hud show:YES];
    // Show the HUD while the provided method executes in a new thread
    

    
    
    //1
    PFUser *user = [PFUser user];
    
    //2
    user.username =userNameTextField.text;
    user.password =passwordTextField.text;
    user.email =userEmailTextField.text;
    
    //3
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            //The registration was successful, go to the wall
            
            [hud hide:YES];
            
            [self registerBackAction:_registerOutlet];
            [self performSegueWithIdentifier:@"loginConfirmed" sender:self];
            
            
        } else {
            //Something bad has occurred
            [hud hide:YES];

            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"خطا " message:@"عملیات ثبت نام انجام نشد دوباره اقدام نمایید" delegate:self cancelButtonTitle:@"بازگشت" otherButtonTitles:nil, nil];
            [self.view addSubview:alert];
            [alert show];

        }
    }];

    
    
    
}
-(void)registerBackAction:(UIButton*)sender{
    
    
    [UIView animateWithDuration:0.3 animations:^{
        regView.alpha=0;
        self.pageTitle.alpha=1;
        self.registerOutlet.alpha=1;
        self.loginOutlet.alpha=1;
        
        CGFloat newScale = 1;
        
        
        CGAffineTransform iTransform = CGAffineTransformMakeScale(newScale, newScale);
        _loginBackgroundImage.transform = iTransform;
        
        [userNameTextField resignFirstResponder];
        [passwordTextField resignFirstResponder];
        [userEmailTextField resignFirstResponder];
        
        //   visualEffectView.alpha=0;
        
    }];

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)firstLogin{
    PFUser *currentUser = [PFUser currentUser];
    if (currentUser) {
        NSLog(@"yes :: %@",currentUser);
        [self performSegueWithIdentifier:@"loginConfirmed" sender:self];
    } else {
        NSLog(@"no");
    }

}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}
-(void)loginAction:(UIButton*)sender{

    
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"دریافت اطلاعات ...";
    [hud show:YES];



    [PFUser logInWithUsernameInBackground:loginUsernameTextField.text password:loginPasswordTextField.text block:^(PFUser *user, NSError *error) {
        if (user) {
            [hud hide:YES];
            
            [self loginBackAction:_loginOutlet];
            

            [self performSegueWithIdentifier:@"loginConfirmed" sender:self];
            
        } else {
            //Something bad has ocurred
//            NSString *errorString = [[error userInfo] objectForKey:@"error"];
//            UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"خطا" message:errorString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
//            [errorAlertView show];
            [hud hide:YES];

            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"خطا " message:@"عملیات ورودی انجام نشد دوباره اقدام نمایید" delegate:self cancelButtonTitle:@"بازگشت" otherButtonTitles:nil, nil];
            [self.view addSubview:alert];
            [alert show];

            
            

            
        
            
        }
    }];
}
-(void)changeBackPic
{
//    NSLog(@"hoooo");
    if (i==2) {
        i=-1;
    }
    i++;
    self.backgroundImage.image=[backPick objectAtIndex:(i)];



//    [self.loginBackgroundImage setImageToBlur:self.loginBackgroundImage.image
//blurRadius:kLBBlurredImageDefaultBlurRadius
//completionBlock:^(){
//    NSLog(@"The blurred image has been set");
//}];
    


}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
@end
