//
//  searchListViewController.h
//  pastaa
//
//  Created by Helia Taghavi on 4/6/15.
//  Copyright (c) 2015 Reza Sazegarnezhad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
@interface searchListViewController : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource,CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *searchCollectionView;
@property NSArray* fetchedResturant;
@property NSMutableArray* resturantListPic;
@property NSMutableArray* resturantAdType;
@property NSMutableArray* resturantName;
@property NSMutableArray* resturantObjectId;
@property NSString* restName;
@property NSString* restCost;
@property NSString* restDiscount;
@property NSInteger restDistance;
@property NSString* restType;
@property NSInteger selected;
@end
