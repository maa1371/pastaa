//
//  addReserveViewController.m
//  pastaa
//
//  Created by Helia Taghavi on 4/8/15.
//  Copyright (c) 2015 Reza Sazegarnezhad. All rights reserved.
//

#import "addReserveViewController.h"
#import "MBProgressHUD.h"


@interface addReserveViewController () <UIAlertViewDelegate>
{

    NSString * count;//reserve count
    NSNumber * time;//reserve time
    NSDate* lastSavedDate;//reserve date
    NSDate* today;
    NSDateFormatter *dateFormatter;
    MBProgressHUD *hud;
    MBProgressHUD *HUD;
    
}
@end

@implementation addReserveViewController

int defaultcount=1;
int defaulTime=8;

- (void)viewDidLoad {
    [super viewDidLoad];
 
    NSLog(@"hamchi aroome %@",self.ResturantObject);
    count =[NSString stringWithFormat:@"%i",defaultcount];
    [_countLabel setTitle:count forState:UIControlStateNormal];
    time =[NSNumber numberWithInt:defaulTime];
    [_timeLabel setTitle:[NSString stringWithFormat:@"%@",time] forState:UIControlStateNormal];
    lastSavedDate=[NSDate date];
    today=[NSDate dateWithTimeInterval:-(24*60*60) sinceDate:[NSDate date]];
    
    [self getDate:lastSavedDate];
    
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    NSCalendar * cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSPersianCalendar];
//    [dateFormatter setCalendar:cal];
//    [dateFormatter setDateFormat:@"yyyy/MM/dd"];
//    
//    NSDateFormatter *weekDateFormatter = [[NSDateFormatter alloc] init] ;
//    [weekDateFormatter setDateFormat:@"EEEE"];
//    NSString *week = [weekDateFormatter stringFromDate:lastSavedDate];
//    
    
//    
//        PFObject *reserve = [PFObject objectWithClassName:@"reserve"];
//    
//        [reserve setObject:[NSNumber numberWithInt:10] forKey:@"Time"];
//    
//    
//        PFUser *iUser=[PFUser currentUser];
//        [reserve setObject:iUser forKey:@"userID"];
//
//    
//        [reserve setObject:@"7msruTxGzC" forKey:@"resturantID"];
//    
//    
//        [reserve setObject:[dateFormatter stringFromDate:lastSavedDate] forKey:@"day"];
//    
//    
//        [reserve setObject:[NSNumber numberWithInt:10]  forKey:@"reserveCount"];
//    
//    
//        [reserve saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//    
//            if (succeeded){
//                NSLog(@"Object Uploaded!");
//            }
//            else{
//                NSString *errorString = [[error userInfo] objectForKey:@"error"];
//                NSLog(@"Error: %@", errorString);
//            }
//            
//        }];
//    
    
    
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    NSCalendar * cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSPersianCalendar];
//    [dateFormatter setCalendar:cal];
//    [dateFormatter setDateFormat:@"yyyy/MM/dd"];
//    NSDateFormatter *weekDateFormatter = [[NSDateFormatter alloc] init] ;
//    [weekDateFormatter setDateFormat:@"EEEE"];
//    NSString *week = [weekDateFormatter stringFromDate:lastSavedDate];
//    
//    
//    
//    PFObject *reserve = [PFObject objectWithClassName:@"reserved"];
//    
//    [reserve setObject:[NSNumber numberWithInt:10] forKey:@"Time"];
//    
//    
//    
//    [reserve setObject:@"7msruTxGzC" forKey:@"resturantID"];
//    
//    
//    [reserve setObject:[dateFormatter stringFromDate:lastSavedDate] forKey:@"day"];
//    
//    
//    [reserve setObject:[NSNumber numberWithInt:10]  forKey:@"remainingReserveCount"];
//    
//    
//    [reserve saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//        
//        if (succeeded){
//            NSLog(@"Object Uploaded!");
//        }
//        else{
//            NSString *errorString = [[error userInfo] objectForKey:@"error"];
//            NSLog(@"Error: %@", errorString);
//        }
//        
//    }];
//    
    

    
    
    
    
      // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)goToPreviousDay:(id)sender {
    NSDate *yesterday = [NSDate dateWithTimeInterval:-(24*60*60) sinceDate:lastSavedDate];
    if ([yesterday compare:today] == NSOrderedDescending) {
        NSLog(@"date1 is earlier than date2");
        [self getDate:yesterday];
        lastSavedDate=yesterday;
    }

    
}
- (IBAction)goToNextDay:(id)sender {
    NSDate *tomorrow = [NSDate dateWithTimeInterval:(24*60*60) sinceDate:lastSavedDate];
    [self getDate:tomorrow];
    lastSavedDate=tomorrow;
}
- (IBAction)increaseCount:(id)sender {
    defaultcount++;
    count =[NSString stringWithFormat:@"%i",defaultcount];
    
    [_countLabel setTitle:count forState:UIControlStateNormal];


}
- (IBAction)decreaseCount:(id)sender {
    defaultcount--;
    if (defaultcount==0) {
        defaultcount=1;
    }
    count =[NSString stringWithFormat:@"%i",defaultcount];
    
    [_countLabel setTitle:count forState:UIControlStateNormal];
    
}
- (IBAction)increaseTime:(id)sender {
   
    defaulTime++;
    
    if (defaulTime==24) {
      
        defaulTime=23;
        
    }
    time =[NSNumber numberWithInt:defaulTime];
    
    [_timeLabel setTitle:[NSString stringWithFormat:@"%@",time] forState:UIControlStateNormal];

}
- (IBAction)decreaseTime:(id)sender {
    defaulTime--;
    if (defaulTime==7) {
        defaulTime=8;
    }
    
    time =[NSNumber numberWithInt:defaulTime];
    [_timeLabel setTitle:[NSString stringWithFormat:@"%@",time] forState:UIControlStateNormal];
    
}
- (IBAction)reserve:(id)sender {
     
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    
    hud.labelText = @"در حال رزرو ...";
    hud.labelFont    =[UIFont fontWithName:@"W_koodak" size:16];
    [hud show:YES];

    PFQuery *query = [PFQuery queryWithClassName:@"reserved"]; //1
    
    [query whereKey:@"day" equalTo:[dateFormatter stringFromDate:lastSavedDate] ];
    [query whereKey:@"resturantID" equalTo:self.ResturantObject.objectId ];
    [query whereKey:@"Time" equalTo:time];
    NSLog(@"day: %@",[dateFormatter stringFromDate:lastSavedDate] );
    NSLog(@"resturantID: %@",self.ResturantObject.objectId );
    NSLog(@"Time: %@",time);
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {//4

        if (!error) {
        ///not error start
            
            NSLog(@"!Error");
            
          //  NSNumber *remaining=[[objects objectAtIndex:0] objectForKey:@"remainingReserveCount"];
            NSNumber * maxTableCount=[self.ResturantObject objectForKey:@"maxTableCount"];
           

            NSLog(@"object Count %lu",(unsigned long)objects.count);
            
            if(objects.count==0){
                //object not exist start
                    
                    ///NO
                    
                    NSLog(@"NO");
                    
                    
                    if (maxTableCount.intValue  >=   count.intValue) {
                        
                        PFObject *reserved = [PFObject objectWithClassName:@"reserved"];
                        
                        [reserved setObject:[NSNumber numberWithInt:time.intValue] forKey:@"Time"];
                        
                        [reserved setObject:self.weekdayLabel.text forKey:@"weekDay"];
                        
                        [reserved setObject:_ResturantObject.objectId forKey:@"resturantID"];
                        
                        [reserved setObject:[dateFormatter stringFromDate:lastSavedDate] forKey:@"day"];
                        
                        [reserved setObject:[NSNumber numberWithInt:maxTableCount.intValue-count.intValue    ] forKey:@"remainingReserveCount"];
                        
                        [reserved saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                            
                            if (succeeded){
                                NSLog(@"Object created!1");
                            }
                            else{
                                NSString *errorString = [[error userInfo] objectForKey:@"error"];
                                NSLog(@"Error: %@", errorString);
                            }
                            
                        }];
                        PFObject *reserve = [PFObject objectWithClassName:@"reserve"];
                        
                        [reserve setObject:[NSNumber numberWithInt:time.intValue] forKey:@"Time"];
                        
                        
                        PFUser *iUser=[PFUser currentUser];
                        [reserve setObject:iUser forKey:@"userID"];
                        
                        NSString * resturantID=self.ResturantObject.objectId;
                        
                        [reserve setObject:resturantID forKey:@"resturantID"];
                        [reserve setObject:[self.ResturantObject objectForKey:@"Name"] forKey:@"resturantName"];
                        
                        
                        [reserve setObject:self.weekdayLabel.text forKey:@"weekDay"];
                        
                        [reserve setObject:[dateFormatter stringFromDate:lastSavedDate] forKey:@"day"];
                        
                        
                        [reserve setObject:[NSNumber numberWithInt:count.intValue]  forKey:@"reserveCount"];
                        
                        
                        [reserve saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                            
                            if (succeeded){
                                NSLog(@"Object Uploaded!");
                                [hud hide:YES];
                                HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                                UIImage *image = [UIImage imageNamed:@"37x-Checkmark.png"];
                                UIImageView* imageView = [[UIImageView alloc] initWithImage:image];
                                HUD.customView= imageView;
                                HUD.mode = MBProgressHUDModeCustomView;
                                HUD.labelFont    =[UIFont fontWithName:@"W_koodak" size:16];
                                
                                HUD.labelText = @"رزرو با موفقیت انجام شد";
                                [UIView animateWithDuration:0.1 animations:^{
                                    //[HUD hide:YES];
                                } completion:^(BOOL finished) {
                                    sleep(2);
                                    
                                    [HUD hide:YES];
                                    [UIView animateWithDuration:0.1 animations:^{
                                        //[HUD hide:YES];
                                    } completion:^(BOOL finished) {
                                        [self dismissViewControllerAnimated:YES completion:^{
                                            
                                        }];

                                        
                                    }];
                                    
                                    
                                }];

                                
                            
                            }
                            else{
                                NSString *errorString = [[error userInfo] objectForKey:@"error"];
                                NSLog(@"Error: %@", errorString);
                                [hud hide:YES];


                            }
                            
                        }];
                        
                        
                        
                        
                    }else{

                        [hud hide:YES];

                        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"ظرفیت محدود است" message:@"بیش از حد مجاز" delegate:self cancelButtonTitle:@"بازگشت" otherButtonTitles:nil, nil];
                        [self.view addSubview:alert];
                        [alert show];
                        
                    }
                //object not exist end

            } else{
                //object  exist start
                NSLog(@"YES");

                
                 NSNumber *remaining=[[objects objectAtIndex:0] objectForKey:@"remainingReserveCount"];
                if (remaining.intValue>=count.intValue) {
                    //start mishe
                    NSLog(@"mishe");
                    [objects objectAtIndex:0][@"remainingReserveCount"]=[NSNumber numberWithInt: remaining.intValue  -count.intValue ];
                    [[objects objectAtIndex:0] saveInBackground];
                    
                    
                    
                    
                    
                    PFObject *reserve = [PFObject objectWithClassName:@"reserve"];
                    
                    [reserve setObject:[NSNumber numberWithInt:time.intValue] forKey:@"Time"];
                    
                    
                    PFUser *iUser=[PFUser currentUser];
                    [reserve setObject:iUser forKey:@"userID"];
                    
                    NSString * resturantID=self.ResturantObject.objectId;
                    
                    [reserve setObject:resturantID forKey:@"resturantID"];
                    
                    [reserve setObject:[self.ResturantObject objectForKey:@"Name"] forKey:@"resturantName"];
                    
                    
                    [reserve setObject:self.weekdayLabel.text forKey:@"weekDay"];
                    
                    [reserve setObject:[dateFormatter stringFromDate:lastSavedDate] forKey:@"day"];
                    
                    
                    [reserve setObject:[NSNumber numberWithInt:count.intValue]  forKey:@"reserveCount"];
                    
                    
                    [reserve saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                        
                        if (succeeded){
                            NSLog(@"Object Uploaded!2");
                            [hud hide:YES];
                            HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                            UIImage *image = [UIImage imageNamed:@"37x-Checkmark.png"];
                            UIImageView* imageView = [[UIImageView alloc] initWithImage:image];
                            HUD.customView= imageView;
                            HUD.mode = MBProgressHUDModeCustomView;
                            HUD.labelFont    =[UIFont fontWithName:@"W_koodak" size:16];
                            
                            HUD.labelText = @"رزرو با موفقیت انجام شد";
                            [UIView animateWithDuration:0.1 animations:^{
                                //[HUD hide:YES];
                            } completion:^(BOOL finished) {
                                sleep(2);
                                
                                [HUD hide:YES];
                                [UIView animateWithDuration:0.1 animations:^{
                                    //[HUD hide:YES];
                                } completion:^(BOOL finished) {
                                    [self dismissViewControllerAnimated:YES completion:^{
                                        
                                    }];
                                    
                                    
                                }];
                                
                                
                            }];


                                    }
                        else{
                            NSString *errorString = [[error userInfo] objectForKey:@"error"];
                            NSLog(@"Error: %@", errorString);
                            [hud hide:YES];

                            }
                        
                    }];

                    
                    
                    //end mishe
                }else{
                   //start nemishe
                                       NSLog(@"nemishe");
                    [hud hide:YES];

                    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"ظرفیت محدود است" message:@"بیش از حد مجاز" delegate:self cancelButtonTitle:@"بازگشت" otherButtonTitles:nil, nil];
                    [self.view addSubview:alert];
                    [alert show];
                    
                    ///end nemishe
                    
                }
                
                
                

                
                
                
                //object  exist end
        }

            //not error end
        }else{
            /// error start
            NSLog(@"Error Occured");
            [hud hide:YES];

            
            
            
            
            ///error start
        }
        
    }];

}
     
- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
-(NSString*)convertToPersianDay:(NSString *)day
{
    NSString* convertedDay=@"";
    NSArray* eDays=[[NSArray alloc]initWithObjects:@"Saturday",@"Sunday",@"Monday",@"Tuesday",@"Wednesday",@"Thursday",@"Friday", nil];
    NSArray* pDays=[[NSArray alloc]initWithObjects:@"شنبه",@"یکشنبه",@"دوشنبه",@"سه شنبه",@"چهارشنبه",@"پنجشنبه",@"جمعه", nil];

    for (int i=0; i<[eDays count]; i++) {
        if ([day isEqualToString:[eDays objectAtIndex:i]]) {
            convertedDay=[pDays objectAtIndex:i];
        }
    }
    return convertedDay;
}
-(void)getDate:(NSDate*)now
{
    
    dateFormatter = [[NSDateFormatter alloc] init];
    NSCalendar * cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSPersianCalendar];
    [dateFormatter setCalendar:cal];
    [dateFormatter setDateFormat:@"yyyy/MM/dd"];
    NSDateFormatter *weekDateFormatter = [[NSDateFormatter alloc] init] ;
    [weekDateFormatter setDateFormat:@"EEEE"];
    NSString *week = [weekDateFormatter stringFromDate:now];
    
    NSLog(@"Converted date to Shamsi = %@ and weekday is:%@",[dateFormatter stringFromDate:now], week);
    NSString *weekday=[self convertToPersianDay:week];
    self.dateLabel.text=[dateFormatter stringFromDate:now];
    self.weekdayLabel.text=weekday;
}

@end
