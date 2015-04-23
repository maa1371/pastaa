//
//  LocationViewController.h
//  pastaa
//
//  Created by Mohammad Hasan Ansari on 12/20/1393 AP.
//  Copyright (c) 1393 AP Reza Sazegarnezhad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
@interface LocationViewController : UIViewController<CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *resturantName;
@property (weak, nonatomic) IBOutlet UILabel *resturantAddress;
@property (weak, nonatomic) IBOutlet MKMapView *resturantMap;
@property CLLocationManager* myManager;
@property NSString* name;
@property NSString* address;
@property CLLocation* location;
@property CLLocation* resturantLocation;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;


@end
