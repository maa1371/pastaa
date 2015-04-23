//
//  resturantMainViewController.m
//  pastaa
//
//  Created by Amin on 3/8/15.
//  Copyright (c) 2015 Reza Sazegarnezhad. All rights reserved.
//

#import "resturantMainViewController.h"
#import "MBProgressHUD.h"
#import <CoreLocation/CoreLocation.h>
#import "ILTranslucentView.h"

@interface resturantMainViewController ()
{
    MBProgressHUD *hud;
    NSArray *resturantImg;

    
}
@end

@implementation resturantMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ILTranslucentView *translucentView = [[ILTranslucentView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:translucentView]; //that's it :)
    
    //optional:
    translucentView.translucentAlpha = 0.6;
    translucentView.translucentStyle = UIBarStyleDefault;
    translucentView.translucentTintColor = [UIColor clearColor];
    translucentView.backgroundColor = [UIColor clearColor];
    [self.view sendSubviewToBack:translucentView];
    [self.view sendSubviewToBack:self.backgroungImage];

//    UIBarButtonItem *shareItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:nil];
//    
// //   self.navigationItem.rightBarButtonItem = shareItem;
//
//    
//    [self.navigationItem setRightBarButtonItem:shareItem];

    
    
//    UIButton* menuBtn=[[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width-55, 0,30, 30)];
//    
//    [menuBtn setBackgroundImage:[UIImage imageNamed:@"menu.png"] forState:UIControlStateNormal];
//    
//    UIBarButtonItem *btnSample = [[UIBarButtonItem alloc] initWithCustomView:menuBtn];
//    
//
//    resturantMainViewController * item1= [resturant.viewControllers objectAtIndex:0];

    
   // self.navigationItem.rightBarButtonItem = btnSample;
    
    
//    UIImage *image = [UIImage imageNamed:@"tik.png"];
//    UIButton *reserveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    reserveBtn.bounds = CGRectMake( 0, 0, image.size.width, image.size.height );
//    [reserveBtn setImage:image forState:UIControlStateNormal];
//    [reserveBtn addTarget:self action:@selector(myAction) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *shareButton = [[UIBarButtonItem alloc] initWithCustomView:reserveBtn];
    
    
    
    
//    UIButton* userBtn=[[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-30, 0,60, 60)];
//    userBtn.backgroundColor=[UIColor blackColor];
//    //[self.navigationController.navigationBar addSubview:userBtn];
    
    self.myManager=[[CLLocationManager alloc]init];
    self.myManager.delegate=self;
    self.myManager.desiredAccuracy=kCLLocationAccuracyBest;
    [self.myManager requestAlwaysAuthorization];
    [self.myManager requestWhenInUseAuthorization];
    
    [[UITabBar appearance] setTintColor:[UIColor redColor]];
    self.LVC=[[LocationViewController alloc]init];
    self.RGVC=[[resturantGalleryViewController alloc]init];
    self.MVC=[[MenuViewController alloc]init];
    self.CVC=[[myCommentViewController alloc]init];
    
    PFObject *iObj=self.resturantObj;
    
//    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    hud.mode = MBProgressHUDModeIndeterminate;
//    hud.labelText = @"دریافت اطلاعات ...";
//    [hud show:YES];
//    
//    
   
    
    
//    PFObject *resturant = [PFObject objectWithClassName:@"menu"];
//    
//    [resturant setObject:@"موهیتو" forKey:@"name"];
//    [resturant setObject:@"نوشیدنی" forKey:@"category"];
//    [resturant setObject:[NSNumber numberWithInt:5000] forKey:@"cost"];
//    [resturant setObject:@"خانم نعنا این غذا رو دوست داره" forKey:@"description"];
//    [resturant setObject:iObj forKey:@"parent"];
//
//    
//    UIImage *img1 = [UIImage imageNamed:@"1kochooloo.png"];
//    NSData *rImgData = UIImagePNGRepresentation(img1);
//    PFFile *rImg = [PFFile fileWithName:@"rSearchImg" data:rImgData];
//    [resturant setObject:rImg forKey:@"rSearchImg"];
//    
//    [resturant saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//        
//        if (succeeded){
//            
//            NSLog(@"Object Uploaded!");
//            
//        }
//        else{
//            NSString *errorString = [[error userInfo] objectForKey:@"error"];
//            NSLog(@"Error: %@", errorString);
//        }
//        
//    }];

    
    
    
    self.tabBarController.delegate=self;

    self.nameLable.text=[NSString stringWithFormat: @"رستـــوران %@",self.name];
    [self.nameLable setFont:[UIFont fontWithName:@"W_koodak" size:23]];
    
    self.maxTableCount.text=[NSString stringWithFormat:@"تعداد صندلی: %@",self.resurantMaxCount];
    [self.maxTableCount setFont:[UIFont fontWithName:@"W_koodak" size:16]];

    self.discountLabel.text=[NSString stringWithFormat:@"تخفیف ویژه: %@",self.resturantDiscount];
    if (![self.resturantIsReady isEqualToString:@"دارد"]) {
        self.isReadyLabel.text=@"آماده سرویس دهی نیست";
    }
    
    [self.discountLabel setFont:[UIFont fontWithName:@"W_koodak" size:16]];
    
    [self.distanceFromYouLabel setFont:[UIFont fontWithName:@"W_koodak" size:16]];
    self.distanceFromYouLabel.text=[NSString stringWithFormat:@"فاصله از شما : ۲۰  کیلومتر"];

    [self.isReadyLabel setFont:[UIFont fontWithName:@"W_koodak" size:16]];
    
    
    
    
    
    
    
    
    PFQuery *query = [PFQuery queryWithClassName:@"resturantImg"]; //1
    
    [query whereKey:@"parent" equalTo:iObj];//2
   
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {//4
        if (!error) {
            NSLog(@"Successfully retrieved: %@", objects);
            resturantImg=[[NSArray alloc]initWithArray:objects];

            PFFile *backImage;
            backImage= (PFFile *)[[objects objectAtIndex:0] objectForKey:@"rImgBack"];
            //  [self.backgroungImage setImage:[UIImage imageWithData:backImage.getData]];
            [self.backgroungImage setImage:[UIImage imageNamed:@"login-page-back2.jpg"]];

            PFFile *logoImg;
            logoImg= (PFFile *)[[objects objectAtIndex:0] objectForKey:@"rImgIcon"];
            // [self.resturantLogo setBackgroundImage:[UIImage imageWithData:logoImg.getData] forState:UIControlStateNormal];
            [self.resturantLogo setBackgroundImage:[UIImage imageNamed:@"login.png"] forState:UIControlStateNormal];
            
            
          //  [hud hide:YES];
        } else {
            NSString *errorString = [[error userInfo] objectForKey:@"error"];
            NSLog(@"Error: %@", errorString);
        }
    }];
   
    
    
    
    
    
    
    PFGeoPoint *resturantPoint;
    resturantPoint=[iObj  objectForKey:@"coordinate"];
    NSLog(@"%@",self.resturantLocation);

//    PFGeoPoint *currentLocation =[[PFGeoPoint alloc]init];
////    currentLocation.latitude=30.5;
////    currentLocation.longitude=20.3;
//    
//   // NSLog(@"distance %f",[resturantPoint distanceInKilometersTo:currentLocation] );
//    
//    
//    [PFGeoPoint geoPointForCurrentLocationInBackground:^(PFGeoPoint *geoPoint, NSError *error) {
// // if (!error) {
////    double distance;
//            //    distance = [geoPoint distanceInKilometersTo:resturantPoint];
//               NSLog(@"location: %@",geoPoint);
//            
//   //     }
//    }];
    
    
    
    self.LVC=[self.tabBarController.viewControllers objectAtIndex:4];
    self.LVC.name=self.nameLable.text;
    self.LVC.address=self.resturantAddress;
    self.LVC.location=self.resturantLocation;
    
    self.RGVC=[self.tabBarController.viewControllers objectAtIndex:2];
    self.RGVC.child=self.resturantChild;
    self.RGVC.wifi=self.resturantWifi;
    self.RGVC.parking=self.resturantParking;
    
    self.MVC=[self.tabBarController.viewControllers objectAtIndex:1];
    self.MVC.ResturantObject=self.resturantObj;
    [self findCurrentLocation];
    
    self.CVC=[self.tabBarController.viewControllers objectAtIndex:3];
    self.CVC.ResturantObject=self.resturantObj;
    
    
    self.distanceFromYouLabel.text=[NSString stringWithFormat:@"فاصله از شما: %f کیلومتر",self.distance];
    
   
    
    
    
    
    
//    PFObject *comment = [PFObject objectWithClassName:@"comment"];
//    
//    PFUser *currentUser = [PFUser currentUser];
//    if (currentUser) {
//      //  NSLog(@"name ,%@",currentUser.objectId);
//    } else {
//        // show the signup or login screen
//    }
//    
//    [comment setObject:currentUser forKey:@"userID"];
//    [comment setObject:currentUser.username forKey:@"name"];
//    [comment setObject:iObj forKey:@"resturantID"];
//   
//    [comment setObject:@"salam ajiijam" forKey:@"message"];
//    
//    
//    
//        [comment saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//    
//            if (succeeded){
//    
//                NSLog(@"Object Uploaded!");
//    
//            }
//            else{
//                NSString *errorString = [[error userInfo] objectForKey:@"error"];
//                NSLog(@"Error: %@", errorString);
//            }
//            
//        }];
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
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    if (tabBarController.selectedIndex == 0)
    {
//        NSLog(@"hi");
//        PFFile* image;
//        ListViewController* test=[[ListViewController alloc]init];
//        image= (PFFile *)[[test.fetchedResturant objectAtIndex:test.selected] objectForKey:@"rSearchImg"];
//        NSLog(@"%@",image);

        // First Tab is selected do something
    }
}
-(void)findCurrentLocation
{
    CLLocationManager *locationManager = [[CLLocationManager alloc] init];
    if ([locationManager locationServicesEnabled])
    {
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        locationManager.distanceFilter = kCLDistanceFilterNone;
        [locationManager startUpdatingLocation];
    }
    CLLocation *location = [locationManager location];
    CLLocationCoordinate2D coordinate = [location coordinate];
    CLLocationCoordinate2D coordinate2 = [self.resturantLocation coordinate];

    self.current=coordinate;
    NSString *latlong = [NSString stringWithFormat:@"%f,%f",self.current.latitude,self.current.longitude];
    NSString *latlong2 = [NSString stringWithFormat:@"%f,%f",coordinate2.latitude,coordinate2.longitude];

    NSLog(@"current Location is:%@", latlong);
    NSLog(@"resturant Location is:%@", latlong2);

    self.distance = [self.resturantLocation distanceFromLocation:location]/1000;
    NSLog(@"distance is %f",self.distance);
}

- (UIImage *)applyBlurOnImage: (UIImage *)imageToBlur withRadius: (CGFloat)blurRadius { CIImage *originalImage = [CIImage imageWithCGImage: imageToBlur.CGImage];
    CIFilter *filter = [CIFilter filterWithName: @"CIGaussianBlur" keysAndValues: kCIInputImageKey, originalImage, @"inputRadius", @(blurRadius), nil];
    CIImage *outputImage = filter.outputImage; CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef outImage = [context createCGImage: outputImage fromRect: [outputImage extent]];
    return [UIImage imageWithCGImage: outImage];
}
@end
