//
//  resturantMainViewController.h
//  pastaa
//
//  Created by Amin on 3/8/15.
//  Copyright (c) 2015 Reza Sazegarnezhad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListViewController.h"
#import "LocationViewController.h"
#import "MenuViewController.h"
#import "resturantGalleryViewController.h"
#import "CommentViewController.h"
#import "myCommentViewController.h"
#import <MapKit/MapKit.h>


#import <Parse/Parse.h>
@interface resturantMainViewController : UIViewController<UITabBarControllerDelegate,CLLocationManagerDelegate>

@property myCommentViewController* CVC;
@property MenuViewController* MVC;

@property resturantGalleryViewController* RGVC;
@property LocationViewController * LVC;
@property NSString* name;
@property NSString* resturantObjectId;
@property NSNumber* resurantMaxCount;
@property NSString* resturantDiscount;
@property NSString* resturantIsReady;
@property NSString* resturantAddress;
@property CLLocation* resturantLocation;
@property NSString* resturantWifi;
@property NSString* resturantChild;
@property NSString* resturantParking;
@property CLLocationManager* myManager;
@property CLLocationCoordinate2D current;
@property CLLocationDistance distance;

@property (weak, nonatomic) IBOutlet UIImageView *backgroungImage;
@property (weak, nonatomic) IBOutlet UIButton *resturantLogo;
@property (weak, nonatomic) IBOutlet UILabel *nameLable;
@property (weak, nonatomic) IBOutlet UILabel *distanceFromYouLabel;
@property (weak, nonatomic) IBOutlet UILabel *discountLabel;
@property (weak, nonatomic) IBOutlet UILabel *isReadyLabel;
@property (weak, nonatomic) IBOutlet UILabel *maxTableCount;
@property  (weak,nonatomic) PFObject * resturantObj;


@end
