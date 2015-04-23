//
//  LocationViewController.m
//  pastaa
//
//  Created by Mohammad Hasan Ansari on 12/20/1393 AP.
//  Copyright (c) 1393 AP Reza Sazegarnezhad. All rights reserved.
//

#import "LocationViewController.h"
#import "ILTranslucentView.h"
@interface LocationViewController ()

@end

@implementation LocationViewController

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
    [self.view sendSubviewToBack:self.backgroundImage];
  //  self.resturantMap.layer.cornerRadius=3;
  //  self.resturantMap.layer.shadowOpacity=0.5;
    self.resturantMap.layer.masksToBounds=NO;
    self.resturantMap.layer.shadowOffset=CGSizeMake(3, 3);
  //  self.resturantMap.layer.shadowColor=[[UIColor blackColor]CGColor];

    self.resturantName.text=self.name;
    self.resturantAddress.text=self.address;
    
    CLLocationManager *locationManager = [[CLLocationManager alloc] init];
//    if ([locationManager locationServicesEnabled])
//    {
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        locationManager.distanceFilter = kCLDistanceFilterNone;
        [locationManager startUpdatingLocation];
//    }
    
    CLLocationCoordinate2D coordinate = [self.location coordinate];
    MKPointAnnotation* annotation=[[MKPointAnnotation alloc]init];
    annotation.coordinate=coordinate;
    annotation.title=self.resturantName.text;
    MKCoordinateRegion region=MKCoordinateRegionMakeWithDistance(coordinate, 1000, 1000);
    [self.resturantMap setRegion:region animated:YES];
    [self.resturantMap addAnnotation:annotation];

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

@end
