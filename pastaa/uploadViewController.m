//
//  uploadViewController.m
//  pastaa
//
//  Created by Amin on 3/9/15.
//  Copyright (c) 2015 Reza Sazegarnezhad. All rights reserved.
//

#import "uploadViewController.h"
#import "MBProgressHUD.h"
#import <Parse/Parse.h>

@interface uploadViewController ()
{
    NSArray *iObj;
    MBProgressHUD *hud;
    
}
@end

@implementation uploadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.


    [Parse setApplicationId:@"rI2NnfWSlTSGONvQo1RcJy7psarVgQ923vyirBwA" clientKey:@"TxxBA1EIPXsA2xdTzTfJb5kQsa1jcdPJy35b6Q5w"];
    
    



    
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"دریافت اطلاعات ...";
    [hud show:YES];
    
    
    
    
    PFQuery *query = [PFQuery queryWithClassName:@"resturant"];
    
    iObj= [[NSArray alloc]initWithArray:[query findObjects]];
    NSLog(@"%@",iObj);
    [hud show:NO];
    
    
    
    
    hud.labelText = @"دریافت  ...";
    [hud show:YES];
    
    
        PFObject *resturantImg = [PFObject objectWithClassName:@"resturantImg"];
    
    
    
        UIImage *img1 = [UIImage imageNamed:@"1kochooloo.png"];
        UIImage *img2 = [UIImage imageNamed:@"2kochooloo.png"];
        UIImage *img3 = [UIImage imageNamed:@"1kochooloo.png"];
        UIImage *img4 = [UIImage imageNamed:@"2kochooloo.png"];
        UIImage *img5 = [UIImage imageNamed:@"1kochooloo.png"];
        UIImage *back = [UIImage imageNamed:@"1kochooloo.png"];
        UIImage *icon = [UIImage imageNamed:@"1kochooloo.png"];
    
    
    
    
    
    
        NSData *rimg1 = UIImagePNGRepresentation(img1);
        NSData *rimg2 = UIImagePNGRepresentation(img2);
        NSData *rimg3 = UIImagePNGRepresentation(img3);
        NSData *rimg4 = UIImagePNGRepresentation(img4);
        NSData *rimg5 = UIImagePNGRepresentation(img5);
    
        NSData *rback = UIImagePNGRepresentation(back);
        NSData *ricon = UIImagePNGRepresentation(icon);
    
    
    
        PFFile *rImg1 = [PFFile fileWithName:@"rImg1" data:rimg1];
        PFFile *rImg2 = [PFFile fileWithName:@"rImg2" data:rimg2];
        PFFile *rImg3 = [PFFile fileWithName:@"rImg3" data:rimg3];
        PFFile *rImg4 = [PFFile fileWithName:@"rImg4" data:rimg4];
        PFFile *rImg5 = [PFFile fileWithName:@"rImg5" data:rimg5];
    
    
    
        PFFile *rImgBack = [PFFile fileWithName:@"rImgBack" data:rback];
        PFFile *rImgIcon = [PFFile fileWithName:@"rImgIcon" data:ricon];
    
    
    
    
    
        [resturantImg setObject:rImg1  forKey:@"rImg1"];
        [resturantImg setObject:rImg2  forKey:@"rImg2"];
        [resturantImg setObject:rImg3  forKey:@"rImg3"];
        [resturantImg setObject:rImg4  forKey:@"rImg4"];
        [resturantImg setObject:rImg5  forKey:@"rImg5"];
    
        [resturantImg setObject:rImgBack  forKey:@"rImgBack"];
        [resturantImg setObject:rImgIcon forKey:@"rImgIcon"];
    
        resturantImg[@"parent"] = [iObj objectAtIndex:9];

    
            [resturantImg saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
    
                if (succeeded){
                    NSLog(@"Object Uploaded!");
                    [hud hide:YES];

                }
                else{
                    NSString *errorString = [[error userInfo] objectForKey:@"error"];
                    NSLog(@"Error: %@", errorString);
                }
                
            }];
    

    
    
    
    
    
    

    
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

@end
