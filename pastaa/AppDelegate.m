//
//  AppDelegate.m
//  pastaa
//
//  Created by Amin on 3/2/15.
//  Copyright (c) 2015 Reza Sazegarnezhad. All rights reserved.
//

#import "AppDelegate.h"
#import "MBProgressHUD.h"
@interface AppDelegate ()
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [Parse enableLocalDatastore] ;
    [Parse setApplicationId:@"rI2NnfWSlTSGONvQo1RcJy7psarVgQ923vyirBwA" clientKey:@"TxxBA1EIPXsA2xdTzTfJb5kQsa1jcdPJy35b6Q5w"];

    
    
    
    
//    
//    
//    PFObject *resturant = [PFObject objectWithClassName:@"resturant"];
//    
//    [resturant setObject:@"افق" forKey:@"Name"];
//    
//    [resturant setObject:[NSNumber numberWithInt:1] forKey:@"ad"];
//    [resturant setObject:[NSNumber numberWithInt:1] forKey:@"adType"];
//    [resturant setObject:@"دارد" forKey:@"child"];
//    [resturant setObject:@"به سختی" forKey:@"parking"];
//    [resturant setObject:@"سعادت آباد" forKey:@"address"];
//    
//    [resturant setObject:@"دارد" forKey:@"wifi"];
//    
//    [resturant setObject:@"دارد" forKey:@"service"];
//   
//    [resturant setObject:@"۲۰٪" forKey:@"takhfif"];
//    [resturant setObject:[NSNumber numberWithInt:10]  forKey:@"maxTableCount"];
//    
//    [resturant setObject:@"بالا" forKey:@"costLevel"];
//    [resturant setObject:[NSNumber numberWithInt:1]  forKey:@"isReady"];
//    
//    
//    
//    PFGeoPoint *currentPoint =
//    [PFGeoPoint geoPointWithLatitude:35.784732
//                           longitude:51.374184];
//
//    [resturant setObject:currentPoint forKey:@"coordinate"];
//    
//    [resturant setObject:@"09352495163" forKey:@"phoneNumber"];
//    [resturant setObject:[NSNumber numberWithInt:0]  forKey:@"likeCount"];
//    [resturant setObject:[NSNumber numberWithInt:0]  forKey:@"disLikeCount"];
//    
//    [resturant setObject:@"این رستوران خوبه ما که حال کردیم در این حد ...   " forKey:@"description"];
//    [resturant setObject:@"سطح بالا" forKey:@"type"];
//    
//    
//    UIImage *img1 = [UIImage imageNamed:@"1kochooloo.png"];
//    UIImage *img2 = [UIImage imageNamed:@"2kochooloo.png"];
//    
//    NSData *rSearchImgData = UIImagePNGRepresentation(img1);
//    NSData *rAdImgData = UIImagePNGRepresentation(img2);
//    
//    PFFile *rSearchImg = [PFFile fileWithName:@"rSearchImg" data:rSearchImgData];
//    PFFile *rAdImg = [PFFile fileWithName:@"rAdImg" data:rAdImgData];
//
//    
// 
//    [resturant setObject:rSearchImg forKey:@"rSearchImg"];
//    [resturant setObject:rAdImg  forKey:@"rAdImg"];
//    
//    [resturant saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
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
    
    
       

    
    
//    PFObject *resturantImg = [PFObject objectWithClassName:@"resturantImg"];
//
//    
//    
//    UIImage *img1 = [UIImage imageNamed:@"1kochooloo.png"];
//    UIImage *img2 = [UIImage imageNamed:@"2kochooloo.png"];
//    UIImage *img3 = [UIImage imageNamed:@"1kochooloo.png"];
//    UIImage *img4 = [UIImage imageNamed:@"2kochooloo.png"];
//    UIImage *img5 = [UIImage imageNamed:@"1kochooloo.png"];
//    UIImage *back = [UIImage imageNamed:@"1kochooloo.png"];
//    UIImage *icon = [UIImage imageNamed:@"1kochooloo.png"];
//
//    
//    
//    
//    
//    
//    NSData *rimg1 = UIImagePNGRepresentation(img1);
//    NSData *rimg2 = UIImagePNGRepresentation(img2);
//    NSData *rimg3 = UIImagePNGRepresentation(img3);
//    NSData *rimg4 = UIImagePNGRepresentation(img4);
//    NSData *rimg5 = UIImagePNGRepresentation(img5);
//    
//    NSData *rback = UIImagePNGRepresentation(back);
//    NSData *ricon = UIImagePNGRepresentation(icon);
//
//    
//    
//    PFFile *rImg1 = [PFFile fileWithName:@"rImg1" data:rimg1];
//    PFFile *rImg2 = [PFFile fileWithName:@"rImg2" data:rimg2];
//    PFFile *rImg3 = [PFFile fileWithName:@"rImg3" data:rimg3];
//    PFFile *rImg4 = [PFFile fileWithName:@"rImg4" data:rimg4];
//    PFFile *rImg5 = [PFFile fileWithName:@"rImg5" data:rimg5];
//    
//    
//    
//    PFFile *rImgBack = [PFFile fileWithName:@"rImgBack" data:rback];
//    PFFile *rImgIcon = [PFFile fileWithName:@"rImgIcon" data:ricon];
//    
//    
//    
//    
//    
//    [resturantImg setObject:rImg1  forKey:@"rImg1"];
//    [resturantImg setObject:rImg2  forKey:@"rImg2"];
//    [resturantImg setObject:rImg3  forKey:@"rImg3"];
//    [resturantImg setObject:rImg4  forKey:@"rImg4"];
//    [resturantImg setObject:rImg5  forKey:@"rImg5"];
//   
//    [resturantImg setObject:rImgBack  forKey:@"rImgBack"];
//    [resturantImg setObject:rImgIcon forKey:@"rImgIcon"];
//    
//        [resturantImg saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
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
    
    
    
    
    
    
    
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
