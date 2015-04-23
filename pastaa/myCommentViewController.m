//
//  myCommentViewController.m
//  pastaa
//
//  Created by Helia Taghavi on 4/21/15.
//  Copyright (c) 2015 Reza Sazegarnezhad. All rights reserved.
//

#import "myCommentViewController.h"
#import "MBProgressHUD.h"
#import "ILTranslucentView.h"
@interface myCommentViewController ()<UITextViewDelegate>
{
    MBProgressHUD *hud;
    MBProgressHUD *hud2;
    float  iHeight;
    CGSize keyboardSize;
    NSInteger select;


    
}
@end

@implementation myCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    iHeight=_iView.contentSize.height;
    self.sendBtn.layer.cornerRadius=2;
    self.iView.layer.cornerRadius=5;
    self.iView.layer.borderWidth=0.5;
    self.iView.layer.borderColor=[[UIColor blackColor]CGColor];
    //_viewHeight.constant=33;
    self.iView.delegate=self;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyInputDownArrow object:nil];

    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification object:self.view.window];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification object:self.view.window];
    
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
    [query orderByAscending:@"createdAt"];

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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)keyboardWillShow:(NSNotification *)notif
{
    NSDictionary* info = [notif userInfo];
    keyboardSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    self.bottomSpace.constant=keyboardSize.height-50;
//    [self.iView setFrame:CGRectMake(0, self.view.frame.size.height-280, self.view.frame.size.width, 50)]; //Or where ever you want the view to go
//    
    
}

- (void)keyboardWillHide:(NSNotification *)notif
{
    self.bottomSpace.constant=0;
    self.iView.text=@"";
    iHeight=33;
    
    _viewHeight.constant=iHeight;
    NSLog(@"%f",iHeight);
//    [self.iView setFrame:CGRectMake(0,self.view.frame.size.height-60, self.view.frame.size.width, 30)]; //return it to its original position
    
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
    select=indexPath.row;
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
            UIView * additionalSeparator = [[UIView alloc] initWithFrame:CGRectMake(20,cell.frame.size.height-1,cell.frame.size.width-40,1)];
            additionalSeparator.backgroundColor = [UIColor redColor];
            [cell addSubview:additionalSeparator];
            cell.commentMessage.text=[_messageArray objectAtIndex:indexPath.row];
            cell.userName.text=[self.userNameArray objectAtIndex:indexPath.row];
        }
    
    
        return cell;
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
    
}
- (void)textViewDidChange:(UITextView *)textView
{
    iHeight=_iView.contentSize.height;
    
    _viewHeight.constant=iHeight;
    NSLog(@"message::%@",self.iView.text);

    //    if (_iViewHeight.constant<iHeight) {
    //    }
}
- (IBAction)sendBtnPressed:(id)sender {
    PFObject *iObj=self.ResturantObject;
    hud2 = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud2.mode = MBProgressHUDModeIndeterminate;
    hud2.labelFont    =[UIFont fontWithName:@"W_koodak" size:16];
    
    hud2.labelText = @"ارسال اطلاعات ...";
    [hud2 show:YES];
    
    PFObject *comment = [PFObject objectWithClassName:@"comment"];
    
    PFUser *currentUser = [PFUser currentUser];
    
    [comment setObject:currentUser forKey:@"userID"];
    
    [comment setObject:currentUser.username forKey:@"name"];
    
    
    [comment setObject:iObj forKey:@"resturantID"];

    [comment setObject:self.iView.text forKey:@"message"];
    
    [self.messageArray addObject:self.iView.text];
    [self.userNameArray addObject:currentUser.username];
    [self.commentTable reloadData];

    [comment saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        
        if (succeeded){
            
            NSLog(@"Object Uploaded!");
           
        }
        else{
            NSString *errorString = [[error userInfo] objectForKey:@"error"];
            NSLog(@"Error: %@", errorString);
        }
        
        [hud2 hide:YES];
    }];
    
   // [self.view reloadInputViews];
    
    [hud show:YES];
    
    [self.iView resignFirstResponder];

    
   // [self.messageArray removeAllObjects];
   // [self.userNameArray removeAllObjects];
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
}

@end
