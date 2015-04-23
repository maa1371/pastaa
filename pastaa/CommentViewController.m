//
//  CommentViewController.m
//  pastaa
//
//  Created by Mohammad Hasan Ansari on 12/24/1393 AP.
//  Copyright (c) 1393 AP Reza Sazegarnezhad. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "CommentViewController.h"
#import "MBProgressHUD.h"
#import "ILTranslucentView.h"
@interface CommentViewController ()
{
    MBProgressHUD *hud;
    MBProgressHUD *hud2;
    CGFloat topGap;
    float  iHeight;
    float   firstHeight;

}
@end

@implementation CommentViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    
    iHeight=_chatInput.contentSize.height;
    firstHeight=_chatInput.contentSize.height;
    _chatInputHeight.constant=33;
    
    
    self.chatInput.delegate=self;
    
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyInputDownArrow object:nil];

    [self.chatInput setFrame:CGRectMake(0,self.view.frame.size.height-60, self.view.frame.size.width, 30)];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification object:self.view.window];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification object:self.view.window];
    
  
    
    
   
    
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillChangeFrameNotification object:nil];
//    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];

    
    self.userNameArray=[[NSMutableArray alloc]init];
    self.messageArray=[[NSMutableArray alloc]init];
    
    PFObject *iObj=self.ResturantObject;
    
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelFont    =[UIFont fontWithName:@"W_koodak" size:16];

    hud.labelText = @"دریافت اطلاعات ...";
    [hud show:YES];
    
    
    
    
    PFQuery *query = [PFQuery queryWithClassName:@"comment"]; //1
    
    [query whereKey:@"resturantID" equalTo:iObj];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {//4
        if (!error) {
            
            NSString *message;
            NSString *user;
            for (int i=0; i <[objects count]; i++) {
               
               // comment = [objects objectAtIndex:i];
                message= [[objects objectAtIndex:i] objectForKey:@"message"];
                user= [[objects objectAtIndex:i] objectForKey:@"name"];
                NSLog(@"user %@",user);
                [self.messageArray addObject:message];
                [self.userNameArray addObject:user];
           
            }
            [self.commentTable reloadData];

            [hud hide:YES];
            
            
            //NSLog(@"Successfully retrieved: %@", objects);
            
            
            //  [hud hide:YES];
        } else {
            NSString *errorString = [[error userInfo] objectForKey:@"error"];
            NSLog(@"Error: %@", errorString);
        }
    }];

    // Do any additional setup after loading the view.
}

- (void)keyboardWillShow:(NSNotification *)notif
{
    [self.iView setFrame:CGRectMake(0, self.view.frame.size.height-280, self.view.frame.size.width, 50)]; //Or where ever you want the view to go
    
    
}

- (void)keyboardWillHide:(NSNotification *)notif
{
    [self.iView setFrame:CGRectMake(0,self.view.frame.size.height-60, self.view.frame.size.width, 30)]; //return it to its original position
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.messageArray count];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    NSString* cellIdentifier=@"myCell";
        CommentCell * cell = (CommentCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            NSArray * topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"CommentCell" owner:self options:nil];
            
            
            
            for(id currentObject in topLevelObjects)
            {
                if([currentObject isKindOfClass:[UITableViewCell class]])
                {
                    
                    cell = [[CommentCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                  reuseIdentifier:cellIdentifier];
                    cell = (CommentCell *)currentObject;
                    UIView * additionalSeparator = [[UIView alloc] initWithFrame:CGRectMake(20,cell.frame.size.height-1,cell.frame.size.width-40,1)];
                    additionalSeparator.backgroundColor = [UIColor redColor];
                    [cell addSubview:additionalSeparator];
                    cell.commentMessage.text=[_messageArray objectAtIndex:indexPath.row];
                    cell.userName.text=[self.userNameArray objectAtIndex:indexPath.row];
                 //   NSLog(@"comment Message %@",cell.commentMessage.text);
                    
                    break;
                }
            }
        }
        else
        {
//            cell.foodImage.image=nil;
//            cell.foodName.text=nil;
//            if (self.imageArray.count >indexPath.row) {
//                cell.foodImage.image=[self.imageArray objectAtIndex:indexPath.row];
//                cell.foodName.text=[self.nameArray objectAtIndex:indexPath.row];
//            }
        }
        
        
        return cell;
    
    
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

//- (void)keyboardWillShow:(NSNotification *)notification {
//
//    NSDictionary *info = [notification userInfo];
//    NSValue *kbFrame = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
//    NSTimeInterval animationDuration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
//    CGRect keyboardFrame = [kbFrame CGRectValue];
//    
////    CGFloat height = keyboardFrame.size.height;
//    
//    NSLog(@"Updating constraints.");
//    // Because the "space" is actually the difference between the bottom lines of the 2 views,
//    // we need to set a negative constant value here.
//   // self.keyboardHeight.constant = height-50;
//    
//    [UIView animateWithDuration:animationDuration animations:^{
//        [self.view layoutIfNeeded];
//    }];
//}
//
//- (void)keyboardWillHide:(NSNotification *)notification {
//    NSDictionary *info = [notification userInfo];
//    NSTimeInterval animationDuration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
//    
//    self.keyboardHeight.constant = 0;
//    [UIView animateWithDuration:animationDuration animations:^{
//        [self.view layoutIfNeeded];
//    }];
//}

- (IBAction)dismissKeyboard:(id)sender {
    [_chatInput resignFirstResponder];
    NSLog(@"%@",_chatInput.text);
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.chatInput resignFirstResponder];
    NSLog(@"%@",self.chatInput.text);
    return YES;
}






- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)tappedView:(UITapGestureRecognizer*)tapper
{
    [_chatInput resignFirstResponder];
}

#pragma mark - THChatInputDelegate

//- (void)chat:(THChatInput*)input sendWasPressed:(NSString*)text
//{
//    _chatInput.text = text;
//    [_chatInput setText:@""];
//    NSLog(@"it was written: %@", text);
//    
//    PFObject *iObj=self.ResturantObject;
//    hud2 = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    hud2.mode = MBProgressHUDModeIndeterminate;
//    hud2.labelFont    =[UIFont fontWithName:@"W_koodak" size:16];
//
//    hud2.labelText = @"ارسال اطلاعات ...";
//    [hud2 show:YES];
//    
//        PFObject *comment = [PFObject objectWithClassName:@"comment"];
//    
//        PFUser *currentUser = [PFUser currentUser];
//        if (currentUser) {
//          //  NSLog(@"name ,%@",currentUser.objectId);
//        } else {
//            // show the signup or login screen
//        }
//    
//        [comment setObject:currentUser forKey:@"userID"];
//        [comment setObject:currentUser.username forKey:@"name"];
//        [comment setObject:iObj forKey:@"resturantID"];
//    
//        [comment setObject:text forKey:@"message"];
//    
//    
//    
//            [comment saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//    
//                if (succeeded){
//    
//                    NSLog(@"Object Uploaded!");
//                    
//                }
//                else{
//                    NSString *errorString = [[error userInfo] objectForKey:@"error"];
//                    NSLog(@"Error: %@", errorString);
//                }
//                [self.commentTable reloadData];
//                
//                [hud2 hide:YES];
//            }];
//    
//    [self.view reloadInputViews];
//    [hud show:YES];
//    
//    
//    
//    [self.messageArray removeAllObjects];
//    [self.userNameArray removeAllObjects];
//    PFQuery *query = [PFQuery queryWithClassName:@"comment"]; //1
//    
//    [query whereKey:@"resturantID" equalTo:iObj];
//    
//    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {//4
//        if (!error) {
//            
//            NSString *message;
//            NSString *user;
//            for (int i=0; i <[objects count]; i++) {
//                
//                // comment = [objects objectAtIndex:i];
//                message= [[objects objectAtIndex:i] objectForKey:@"message"];
//                user= [[objects objectAtIndex:i] objectForKey:@"name"];
//                NSLog(@"user %@",user);
//                [self.messageArray addObject:message];
//                [self.userNameArray addObject:user];
//                
//            }
//            [self.commentTable reloadData];
//            
//            [hud hide:YES];
//            
//            
//            //NSLog(@"Successfully retrieved: %@", objects);
//            
//            
//            //  [hud hide:YES];
//        } else {
//            NSString *errorString = [[error userInfo] objectForKey:@"error"];
//            NSLog(@"Error: %@", errorString);
//        }
//    }];
//}


//- (void)chatShowAttachInput:(THChatInput*)input
//{
//    
//}

- (void)textViewDidChange:(UITextView *)textView
{
    iHeight=_chatInput.frame.size.height;
  
    //_chatInputHeight.constant=iHeight;
    _iViewHeight.constant=iHeight;

    [self.iView setFrame:CGRectMake(0, self.view.frame.size.height-250, self.view.frame.size.width, iHeight)]; //Or where ever you want the view to go
    
   // [self.chatInput setFrame:CGRectMake(0, 20, self.view.frame.size.width,iHeight)]; //Or where ever you want the view to go
    
//        if (_chatInputHeight.constant<iHeight) {
//        }
}


@end
