//
//  resturantGalleryViewController.h
//  pastaa
//
//  Created by Amin on 3/9/15.
//  Copyright (c) 2015 Reza Sazegarnezhad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TAPageControl.h"
@interface resturantGalleryViewController : UIViewController<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *resturantWifiLabel;
@property (weak, nonatomic) IBOutlet UILabel *resturantParkingLabel;
@property (weak, nonatomic) IBOutlet UILabel *resturantChildLabel;
@property (strong, nonatomic) TAPageControl *customPageControl;
@property (weak, nonatomic) IBOutlet UIView *wrapper;
@property (strong, nonatomic) NSArray *imagesData;
@property NSString* child;
@property NSString* wifi;
@property NSString* parking;
@end
