//
//  userViewController.m
//  pastaa
//
//  Created by Helia Taghavi on 4/12/15.
//  Copyright (c) 2015 Reza Sazegarnezhad. All rights reserved.
//

#import "userViewController.h"
#import "MBProgressHUD.h"
#import "ILTranslucentView.h"
@interface userViewController ()
{
    MBProgressHUD* hud;
    int* select;
}
@end

@implementation userViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.reserveTable.allowsMultipleSelectionDuringEditing = NO;

    ILTranslucentView *translucentView = [[ILTranslucentView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:translucentView]; //that's it :)
    
    //optional:
    translucentView.translucentAlpha = 0.6;
    translucentView.translucentStyle = UIBarStyleDefault;
    translucentView.translucentTintColor = [UIColor clearColor];
    translucentView.backgroundColor = [UIColor clearColor];
    [self.view sendSubviewToBack:translucentView];
    [self.view sendSubviewToBack:self.backgroundImage];
    
    
    self.reservedResturants=[[NSMutableArray alloc]init];
    self.dates=[[NSMutableArray alloc]init];
    self.hours=[[NSMutableArray alloc]init];
    self.rCount=[[NSMutableArray alloc]init];
   // self.names=[[NSMutableArray alloc]init];
    self.resturantName=[[NSMutableArray alloc]init];
   // self.restID=[[NSMutableArray alloc]init];
    self.reserveID=[[NSMutableArray alloc]init];
    UIView * additionalSeparator = [[UIView alloc] initWithFrame:CGRectMake(20,self.myReserveLabel.frame.size.height-3,self.myReserveLabel.frame.size.width-40,3)];
    additionalSeparator.backgroundColor = [UIColor redColor];
    [self.myReserveLabel addSubview:additionalSeparator];
    PFUser* user=[PFUser currentUser];
    self.usernameLabel.text=user.username;
    self.emailLabel.text=[NSString stringWithFormat:@"ایمیل: %@",user.email];
    PFQuery *query = [PFQuery queryWithClassName:@"reserve"];
    //[query fromLocalDatastore];
    [query whereKey:@"userID" equalTo:user];
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelFont    =[UIFont fontWithName:@"W_koodak" size:16];
    hud.labelText = @"دریافت اطلاعات ...";
    [hud show:YES];
    
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            NSLog(@"Successfully retrieved");
            [hud hide:YES];
            self.reservedResturants=(NSMutableArray*)objects;
            for (int i=0; i<[self.reservedResturants count]; i++) {
                NSNumber *hour;
                NSString *date;
                NSNumber *count;
                NSString *name;
                NSString *objID;
                hour = [[self.reservedResturants objectAtIndex:i] objectForKey:@"Time"];
                date= [[self.reservedResturants objectAtIndex:i] objectForKey:@"day"];
                count= [[self.reservedResturants objectAtIndex:i] objectForKey:@"reserveCount"];
                objID= [[self.reservedResturants objectAtIndex:i]objectId];
              
                
                name=[[self.reservedResturants objectAtIndex:i] objectForKey:@"resturantName"];
                
                [self.resturantName addObject:(NSString*)name];
                [self.hours addObject:hour];
                [self.dates addObject:date];
                [self.rCount addObject:count];
                [self.reserveID addObject:objID];
            }
            [self.reserveTable reloadData];
            //  [PFObject pinAllInBackground:objects];
            
        } else {
            NSString *errorString = [[error userInfo] objectForKey:@"error"];
            NSLog(@"Error: %@", errorString);
        }
    }];
    [self.reserveTable reloadData];

    
    NSLog(@"Y&&& %@",self.resturantName);
    // Do any additional setup after loading the view.
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
    return [self.reservedResturants count];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
   
        reserveCell * cell = (reserveCell *)[tableView dequeueReusableCellWithIdentifier:@"reserve"];
        if (cell == nil) {
//            cell=[[reserveCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reserve"];
            NSArray * topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"reserveCell" owner:self options:nil];
            for(id currentObject in topLevelObjects)
            {
                cell=[[reserveCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reserve"];

                if([currentObject isKindOfClass:[UITableViewCell class]])
                {
                    cell = (reserveCell *)currentObject;
                    UIView * additionalSeparator = [[UIView alloc] initWithFrame:CGRectMake(20,cell.frame.size.height-1,cell.frame.size.width-40,1)];
                    additionalSeparator.backgroundColor = [UIColor redColor];
                    [cell addSubview:additionalSeparator];
                    if (self.resturantName.count>indexPath.row) {
                        cell.resturantName.text=[NSString stringWithFormat:@"رستوران %@",[self.resturantName objectAtIndex:indexPath.row]];
                    }
                    if (self.dates.count>indexPath.row) {
                        cell.reserveDate.text=[self.dates objectAtIndex:indexPath.row];
                    }
                    if (self.hours.count>indexPath.row) {
                        cell.reserveHour.text=[NSString stringWithFormat:@"%@ الی %i",[self.hours objectAtIndex:indexPath.row],((NSString*)[self.hours objectAtIndex:indexPath.row]).intValue+1] ;
                    }
                    if (self.rCount.count>indexPath.row)
                    {
                        cell.reserveCount.text=[NSString stringWithFormat:@"%@ نفر", [self.rCount objectAtIndex:indexPath.row]];
                    }
                    if (self.reserveID.count>indexPath.row)
                    {
                        cell.reserveCode.text=[NSString stringWithFormat:@"کد رزرو شما: %@", [self.reserveID objectAtIndex:indexPath.row]];
                    }

                    break;
                }
            }
        }
        else
        {
            UIView * additionalSeparator = [[UIView alloc] initWithFrame:CGRectMake(20,cell.frame.size.height-1,cell.frame.size.width-40,1)];
            additionalSeparator.backgroundColor = [UIColor redColor];
            [cell addSubview:additionalSeparator];
            if (self.resturantName.count>indexPath.row) {
                cell.resturantName.text=[NSString stringWithFormat:@"رستوران %@",[self.resturantName objectAtIndex:indexPath.row]];
            }
            if (self.dates.count>indexPath.row) {
                cell.reserveDate.text=[self.dates objectAtIndex:indexPath.row];
            }
            if (self.hours.count>indexPath.row) {
                cell.reserveHour.text=[NSString stringWithFormat:@"%@ الی %i",[self.hours objectAtIndex:indexPath.row],((NSString*)[self.hours objectAtIndex:indexPath.row]).intValue+1] ;
            }
            if (self.rCount.count>indexPath.row)
            {
                cell.reserveCount.text=[NSString stringWithFormat:@"%@ نفر", [self.rCount objectAtIndex:indexPath.row]];
            }
            if (self.reserveID.count>indexPath.row)
            {
                cell.reserveCode.text=[NSString stringWithFormat:@"کد رزرو شما: %@", [self.reserveID objectAtIndex:indexPath.row]];
            }

        }
    
    
        return cell;
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}





// Override to support conditional editing of the table view.
// This only needs to be implemented if you are going to be returning NO
// for some items. By default, all items are editable.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}




//
//// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {

    
    if (editingStyle == UITableViewCellEditingStyleDelete) {

        
    
        
//        PFQuery *query = [PFQuery queryWithClassName:@"reserve"];
//       
//       
//        PFObject *myobject = [PFObject objectWithClassName:@"reserve"];
//        [myobject whereKey:@"objectId" equalTo:[self.reserveID objectAtIndex:indexPath.row]];
//
//        [myobject deleteInBackground];
//
       

       
        
        
        
        
        
//        PFObject *reserved = [PFObject objectWithClassName:@"reserved"];
//        
//        
//        [reserved setObject:[[_reservedResturants objectAtIndex:indexPath.row] objectId] forKey:@"resturantID"];
//        
//        
//        NSDateFormatter *dateFormatter;
//        dateFormatter = [[NSDateFormatter alloc] init];
//        NSCalendar * cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSPersianCalendar];
//        [dateFormatter setCalendar:cal];
//        [dateFormatter setDateFormat:@"yyyy/MM/dd"];
//        
//        
//
//        [reserved setObject:[dateFormatter stringFromDate:[_dates objectAtIndex:indexPath.row]] forKey:@"day"];
//        
//        
//        int remainingReservedCount=[[reserved objectForKey:@"remainingReserveCount"]intValue];
//        
//        
//        [reserved setObject:   [NSNumber numberWithInt:remainingReservedCount+ [[_rCount objectAtIndex:indexPath.row]intValue] ]   forKey:@"remainingReserveCount"];
//        
//       
//        [reserved saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//            
//            if (succeeded){
//                NSLog(@"Object created!1");
//            }
//            else{
//                NSString *errorString = [[error userInfo] objectForKey:@"error"];
//                NSLog(@"Error: %@", errorString);
//            }
//        }];

        
        
//        PFObject *deleteObject= [_reservedResturants objectAtIndex:indexPath.row];
//        [deleteObject deleteInBackground];
//        
//        
//        
//        
//        [_reservedResturants removeObjectAtIndex:indexPath.row];
//        [_hours removeObjectAtIndex:indexPath.row];
//        [_dates removeObjectAtIndex:indexPath.row];
//        [_rCount removeObjectAtIndex:indexPath.row];
//        [_resturantName removeObjectAtIndex:indexPath.row];
////        [_restID removeObjectAtIndex:indexPath.row];
//        [_reserveID removeObjectAtIndex:indexPath.row];
//
//
//        
//        
//        
//        
//        NSLog(@"delete");
        
    }
         
    [self.reserveTable reloadData];
}


-(NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewRowAction *shareAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"هدیه به دوستان" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath){
        
        
        
        
        NSString *textToShare1=@"سلام دوست عزیزم";
        
        
        

        NSString *textToShare2=@"شما رو به روستوران ";
        NSString *textToShare3= [_resturantName objectAtIndex:indexPath.row];
        
        NSString *textToShare4=@"در تاریخ";
        NSString *textToShare5= [_dates objectAtIndex:indexPath.row];
        
        NSString *textToShare6=@"ساعت";
       
        NSString *textToShare7=[NSString stringWithFormat:@"%@ الی %i",[self.hours objectAtIndex:indexPath.row],((NSString*)[self.hours objectAtIndex:indexPath.row]).intValue+1];
        NSString *textToShare8=@"دعوت میکنم";
        NSString *textToShare9=@"کد رزرو شما ";
        NSString *textToShare10=[_reserveID objectAtIndex:indexPath.row];

        
        
        NSURL *myWebsite = [NSURL URLWithString:@"http://www.pastaa.com"];
        
        
        
        
        UIActivityViewController *activityViewController =
        [[UIActivityViewController alloc] initWithActivityItems:@[textToShare1,textToShare2,textToShare3,textToShare4,textToShare5,textToShare6,textToShare7,textToShare8,textToShare9,textToShare10,myWebsite ]
                                          applicationActivities:nil];
        [self presentViewController:activityViewController
                           animated:YES
                         completion:^{
                             if ([activityViewController respondsToSelector:@selector(popoverPresentationController)])
                             {
                                 UIPopoverPresentationController *presentationController = [activityViewController popoverPresentationController];
                                 
                                 presentationController.sourceView = self.view;
                             }
                         }];
        


        
        
    }];
    shareAction.backgroundColor = [UIColor greenColor];
    
    
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"کنسل"  handler:^(UITableViewRowAction *action, NSIndexPath *indexPath){
        
        
        
        
        
        PFObject *deleteObject= [_reservedResturants objectAtIndex:indexPath.row];
        [deleteObject deleteInBackground];
        
        
        
        
        [_reservedResturants removeObjectAtIndex:indexPath.row];
        [_hours removeObjectAtIndex:indexPath.row];
        [_dates removeObjectAtIndex:indexPath.row];
        [_rCount removeObjectAtIndex:indexPath.row];
        [_resturantName removeObjectAtIndex:indexPath.row];
        //        [_restID removeObjectAtIndex:indexPath.row];
        [_reserveID removeObjectAtIndex:indexPath.row];
        
        
        
        
        
        
        NSLog(@"delete");
        [self.reserveTable reloadData];

        
        
    }];
    deleteAction.backgroundColor = [UIColor redColor];;

    
    return @[deleteAction,shareAction];
}




@end
