//
//  ListViewController.h
//  pastaa
//
//  Created by Amin on 3/3/15.
//  Copyright (c) 2015 Reza Sazegarnezhad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <MapKit/MapKit.h>
#import "AKPickerView.h"
#import "resturantMainViewController.h"
#import "searchListViewController.h"
@interface ListViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate>
{
    UIView* searchView;
    NSMutableArray* buttonsTitle;
    BOOL isMenuOn;
    BOOL isFilterOn;
    UIButton* menuBtn;
    UIButton* filterBtn;
    
}

@property (weak, nonatomic) IBOutlet UIButton *filterButton;
@property NSInteger selected;
@property NSString* objectId;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionList;

@property NSMutableArray* fetchedResturant;
@property NSArray* resturants;
@property NSMutableArray* resturantListPic;
@property NSMutableArray* resturantAdType;
@property NSMutableArray* resturantName;
@property NSMutableArray* resturantObjectId;
@property (weak, nonatomic) IBOutlet UIView *listView;

@property NSString* restName;
@property NSString* restCost;
@property NSString* restDiscount;
@property NSInteger restDistance;
@property NSString* restType;


@end
