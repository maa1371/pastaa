//
//  ListViewController.m
//  pastaa
//
//  Created by Amin on 3/3/15.
//  Copyright (c) 2015 Reza Sazegarnezhad. All rights reserved.
//

#import "ListViewController.h"
#import "TabViewController.h"
#import "MBProgressHUD.h"
#import "searchFilterView.h"
#import "LoginViewController.h"


@interface ListViewController ()<AKPickerViewDataSource, AKPickerViewDelegate,UITextFieldDelegate>
{
    MBProgressHUD *hud;
    UIButton* userBtn;
    UIView* pastaaView;
    UIView* aboutUsView;
    UITapGestureRecognizer* tapOnView;
    LoginViewController   *login;
}
@property (nonatomic, strong) AKPickerView *resturantTypePickerView;
@property (nonatomic, strong) NSArray *resturantTypeTitles;
@property (nonatomic, strong) AKPickerView *resturantCostLevelPickerView;
@property (nonatomic, strong) NSArray *resturantCostLevelTitles;
@property (nonatomic, strong) AKPickerView *resturantDiscountPickerView;
@property (nonatomic, strong) NSArray *resturantDiscountTitles;
@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"view did load");
    tapOnView=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapOnPage:)];

    
    pastaaView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width/1.2, self.view.frame.size.height/1.5)];
    pastaaView.backgroundColor=[UIColor redColor];
    pastaaView.center=self.view.center;
    pastaaView.layer.cornerRadius=6;
    
    aboutUsView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width/1.2, self.view.frame.size.height/1.5)];
    aboutUsView.backgroundColor=[UIColor yellowColor];
    aboutUsView.center=self.view.center;
    aboutUsView.layer.cornerRadius=6;
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];

    
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.8 green:0 blue:0 alpha:1];
    
    userBtn=[[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-25, 0,50, 50)];
    userBtn.layer.cornerRadius=25;
    [userBtn setBackgroundImage:[UIImage imageNamed:@"person.png"] forState:UIControlStateNormal];
    [userBtn addTarget:self action:@selector(userBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:userBtn];
    
    menuBtn=[[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width-55, 0,100/3, 64/3)];
    menuBtn.layer.cornerRadius=25;
    [menuBtn setBackgroundImage:[UIImage imageNamed:@"menu.png"] forState:UIControlStateNormal];
    [menuBtn addTarget:self action:@selector(sideMenuAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btnSample = [[UIBarButtonItem alloc] initWithCustomView:menuBtn];

    self.navigationItem.rightBarButtonItem = btnSample;
    
    filterBtn=[[UIButton alloc]initWithFrame:CGRectMake(5, 0,69/3, 72/3)];
    filterBtn.layer.cornerRadius=25;
    [filterBtn setBackgroundImage:[UIImage imageNamed:@"filter.png"] forState:UIControlStateNormal];
    [filterBtn addTarget:self action:@selector(filterButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *filterBtnSample = [[UIBarButtonItem alloc] initWithCustomView:filterBtn];
    self.navigationItem.leftBarButtonItem = filterBtnSample;
    //self.navigationItem.titleView=userBtn;
    
    
    isMenuOn=NO;
    isFilterOn=NO;
    buttonsTitle=[[NSMutableArray alloc]initWithObjects:    @"پستا",@"درباره ما",@"خروج",nil];
    
    
    self.resturantListPic=[[NSMutableArray alloc]init];
    self.resturants=[[NSArray alloc]init];
    self.resturantAdType=[[NSMutableArray alloc]init];
    self.resturantName=[[NSMutableArray alloc]init];
    
    self.fetchedResturant=[[NSMutableArray alloc]init];
    self.resturantObjectId=[[NSMutableArray alloc]init];
    
    self.collectionList.layer.shadowOpacity=0.5;
    self.collectionList.layer.masksToBounds=NO;
    self.collectionList.layer.shadowOffset=CGSizeMake(5, 5);
    self.collectionList.layer.shadowColor=[[UIColor blackColor]CGColor];

    self.restDiscount=@"مهم نیست";
    self.restType=@"مهم نیست";
    self.restDistance=1;
    self.restCost=@"مهم نیست";
    self.restName=@"مهم نیست";
    
    for (int i=0; i<[buttonsTitle count]; i++) {
        UIButton* button=[[UIButton alloc]initWithFrame:CGRectMake(self.view.center.x, self.view.frame.origin.y + (i+1)*45 + (i)*4, self.view.frame.size.width/2, 45)];
        button.backgroundColor=[UIColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:1];
        [button setTitle:[buttonsTitle objectAtIndex:i] forState:UIControlStateNormal];
        button.titleLabel.font=[UIFont fontWithName:@"W_koodak" size:16];
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
//        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.listView addSubview:button];
    }
    
    [self.view addSubview:pastaaView];
    pastaaView.alpha=0;
    
    [self.view addSubview:aboutUsView];
    aboutUsView.alpha=0;
    
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelFont    =[UIFont fontWithName:@"W_koodak" size:16];
    hud.labelText = @"دریافت اطلاعات ...";
    [hud show:YES];
    
    
    PFQuery *query = [PFQuery queryWithClassName:@"resturant"];
     //[query fromLocalDatastore];
    [query whereKey:@"ad" equalTo:[NSNumber numberWithInt:1]];
    
    
//    PFQuery *iquery = [PFQuery queryWithClassName:@"resturant"];
//    [iquery fromLocalDatastore];
//    [iquery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//        if (!error) {
//            
//            NSLog(@"1Successfully retrieved: %@", objects);
//            [hud hide:YES];
//            
//            [self.collectionList reloadData];
//            
//        }
//    }];
//    
    
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
           
            NSLog(@"Successfully retrieved: %@", objects);
            [hud hide:YES];

            self.resturants=objects;
            for (id obj in self.resturants) {
                if ([[obj objectForKey:@"adType"]integerValue] == 1) {
                    [self.fetchedResturant addObject:obj];
                }
            }
            for (id obj in self.resturants) {
                if ([[obj objectForKey:@"adType"]integerValue] == 2) {
                    [self.fetchedResturant addObject:obj];
                }
            }
            for (int i=0; i<[self.fetchedResturant count]; i++) {

                NSNumber *adT;
                NSString *name;
                NSString *objectId;
                PFFile *image;

                adT = [[self.fetchedResturant objectAtIndex:i] objectForKey:@"adType"];
                name= [[self.fetchedResturant objectAtIndex:i] objectForKey:@"Name"];
                objectId= [[self.fetchedResturant objectAtIndex:i] objectId];
                image= (PFFile *)[[self.fetchedResturant objectAtIndex:i] objectForKey:@"rAdImg"];
                
                [self.resturantAdType addObject:adT];
                [self.resturantName addObject:name];
                [self.resturantListPic addObject:[UIImage imageWithData:image.getData]];
                [self.resturantObjectId addObject:objectId];
                
            }
            
            
            [self.collectionList reloadData];
            
          //  [PFObject pinAllInBackground:objects];
            
        } else {
            NSString *errorString = [[error userInfo] objectForKey:@"error"];
            NSLog(@"Error: %@", errorString);
        }
    }];

   
//    PFQuery *query = [PFQuery queryWithClassName:@"resturant"];
//    [query whereKey:@"ad" equalTo:[NSNumber numberWithInt:1]];

//    self.fetchedResturant=[[NSMutableArray alloc]initWithArray:[query findObjects]];
    
   
//    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//        if (!error) {
//           // NSLog(@"Successfully retrieved: %@", objects);
//            for (PFObject *res in objects) {
//                self.resturant=[PFObject objectWithClassName:@"resturant"];
//                self.resturant=res;
//                PFFile *adT = (PFFile *)[res objectForKey:@"adType"];
//                [self.fetchedResturant addObject:[NSNumber numberWithInt:(int)adT]];
//                
//                NSLog(@"%@",adT);
//            }
//        } else {
//            NSString *errorString = [[error userInfo] objectForKey:@"error"];
//            NSLog(@"Error: %@", errorString);
//        }
//        NSLog(@"fetchedResturant objects:%@",self.fetchedResturant);
//        self.resturantAdType=[[NSMutableArray alloc]initWithArray:self.fetchedResturant];
//    }];
    //NSLog(@"adType objects:%@",self.resturantAdType);
//    NSLog(@"names objects:%@",self.resturantName);

    
    NSArray * filterObjects = [[NSBundle mainBundle] loadNibNamed:@"searchFilterView" owner:self options:nil];
    for(id currentObject in filterObjects)
    {
        if([currentObject isKindOfClass:[UIView class]])
        {
            searchView=(searchFilterView*)currentObject;
            searchView.frame=self.view.bounds;

        }
    }
    ((searchFilterView*)searchView).resturantName.delegate=self;
    ((searchFilterView*)searchView).resturantDistance.layer.cornerRadius=5;
    ((searchFilterView*)searchView).searchResturantListButton.layer.cornerRadius=5;
    [((searchFilterView*)searchView).searchResturantListButton.titleLabel setFont:[UIFont fontWithName:@"W_koodak" size:14]];
    [self.view addSubview:searchView];
    [self.view bringSubviewToFront:searchView];
    searchView.transform=CGAffineTransformMakeTranslation(0, -searchView.frame.size.height);
    
    [((searchFilterView*)searchView).searchResturantListButton addTarget:self action:@selector(searchResturantList:) forControlEvents:UIControlEventTouchUpInside];
    if (((searchFilterView*)searchView).resturantName.text.length>0 ) {
        ((searchFilterView*)searchView).increaseDistanceBtn.userInteractionEnabled=NO;
        ((searchFilterView*)searchView).decreaseDistanceBtn.userInteractionEnabled=NO;

    }
    if (((searchFilterView*)searchView).resturantName.text.length==0 ) {
        ((searchFilterView*)searchView).increaseDistanceBtn.userInteractionEnabled=YES;
        ((searchFilterView*)searchView).decreaseDistanceBtn.userInteractionEnabled=YES;
        
    }
    self.resturantTypePickerView = [[AKPickerView alloc] initWithFrame:((searchFilterView*)searchView).resturantType.bounds];
    self.resturantTypePickerView.delegate = self;
    self.resturantTypePickerView.dataSource = self;
    self.resturantTypePickerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    self.resturantTypePickerView.font = [UIFont fontWithName:@"W_koodak" size:14];
    self.resturantTypePickerView.highlightedFont = [UIFont fontWithName:@"W_koodak" size:14];
    self.resturantTypePickerView.interitemSpacing = 20.0;
    self.resturantTypePickerView.fisheyeFactor = 0.001;
    self.resturantTypePickerView.pickerViewStyle = AKPickerViewStyle3D;
    self.resturantTypePickerView.maskDisabled = false;
    self.resturantTypeTitles = @[@"مهم نیست",
                                 @"گیاهی",@"ایتالیایی",
                                 @"فست فود",
                                 @"گریل",
                                 @"ساندویچی",
                                 @"غذای دریایی",
                                 @"سفره خانه",
                                 @"کبابی",
                                 @"چلو کبابی",
                                 @"بوفه",
                                 @"تهیه غذا"];
    
    [self.resturantTypePickerView reloadData];
    
    [((searchFilterView*)searchView).resturantType addSubview:self.resturantTypePickerView];
    
    self.resturantCostLevelPickerView = [[AKPickerView alloc] initWithFrame:((searchFilterView*)searchView).resturantCostLevel.bounds];
    self.resturantCostLevelPickerView.delegate = self;
    self.resturantCostLevelPickerView.dataSource = self;
    self.resturantCostLevelPickerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    self.resturantCostLevelPickerView.font = [UIFont fontWithName:@"W_koodak" size:14];
    self.resturantCostLevelPickerView.highlightedFont = [UIFont fontWithName:@"W_koodak" size:14];
    self.resturantCostLevelPickerView.interitemSpacing = 20.0;
    self.resturantCostLevelPickerView.fisheyeFactor = 0.001;
    self.resturantCostLevelPickerView.pickerViewStyle = AKPickerViewStyle3D;
    self.resturantCostLevelPickerView.maskDisabled = false;
    self.resturantCostLevelTitles = @[@"مهم نیست",
                                 @"اقتصادی",
                                 @"متوسط",
                                 @"بالا",
                                 @"بسیار بالا",
];
    
    [self.resturantCostLevelPickerView reloadData];
    [((searchFilterView*)searchView).resturantCostLevel addSubview:self.resturantCostLevelPickerView];
    
    self.resturantDiscountPickerView = [[AKPickerView alloc] initWithFrame:((searchFilterView*)searchView).resturantDiscount.bounds];
    self.resturantDiscountPickerView.delegate = self;
    self.resturantDiscountPickerView.dataSource = self;
    self.resturantDiscountPickerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    self.resturantDiscountPickerView.font = [UIFont fontWithName:@"W_koodak" size:14];
    self.resturantDiscountPickerView.highlightedFont = [UIFont fontWithName:@"W_koodak" size:14];
    self.resturantDiscountPickerView.interitemSpacing = 20.0;
    self.resturantDiscountPickerView.fisheyeFactor = 0.001;
    self.resturantDiscountPickerView.pickerViewStyle = AKPickerViewStyle3D;
    self.resturantDiscountPickerView.maskDisabled = false;
    self.resturantDiscountTitles = @[@"مهم نیست",
                                      @"دارد",
                                      @"ندارد",
    ];
    
    [self.resturantDiscountPickerView reloadData];
    [((searchFilterView*)searchView).resturantDiscount addSubview:self.resturantDiscountPickerView];
    
    
   
 
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
  //  NSLog(@"resturant count %lu",(unsigned long)[self.resturantAdType count]);
    return [self.resturantAdType count];
}


-(UICollectionViewCell*) collectionView:(UICollectionView *)collectionView
                 cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell* cell = [self.collectionList dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    UIImageView *recipeImageView = (UIImageView *)[cell viewWithTag:100];
    recipeImageView.image = [self.resturantListPic objectAtIndex:indexPath.row];
//    cell.backgroundView=[[UIImageView alloc]initWithImage:[self.resturantListPic objectAtIndex:indexPath.row]];
    
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //You may want to create a divider to scale the size by the way..
    CGSize cellSize;
    if ([[self.resturantAdType objectAtIndex:indexPath.row]integerValue]==1) {
        cellSize=CGSizeMake(self.collectionList.frame.size.width-0.5, self.collectionList.frame.size.height/3.8);
        
    }
    else
        cellSize=CGSizeMake(self.collectionList.frame.size.width/2-0.5, self.collectionList.frame.size.height/3.8);
    return cellSize;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    self.selected=indexPath.row;
    [self performSegueWithIdentifier:@"goToResturantDetail" sender:self];
    
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"goToResturantDetail"]) {
    
    TabViewController* resturant=(TabViewController*)segue.destinationViewController;
    resturant.restObject=[self.fetchedResturant objectAtIndex:self.selected];
    resturantMainViewController * item1= [resturant.viewControllers objectAtIndex:0];
    
    [item1 setName:[self.resturantName objectAtIndex:_selected]];
    [item1 setResturantObjectId:[self.resturantObjectId objectAtIndex:_selected]];
    [item1 setResurantMaxCount:[[self.fetchedResturant objectAtIndex:self.selected] objectForKey:@"maxTableCount"]];
    [item1 setResturantObj:[self.fetchedResturant objectAtIndex:self.selected]];
    [item1 setResturantDiscount:[[self.fetchedResturant objectAtIndex:self.selected] objectForKey:@"takhfif"]];
    [item1 setResturantIsReady:[[self.fetchedResturant objectAtIndex:self.selected] objectForKey:@"service"]];
    [item1 setResturantAddress:[[self.fetchedResturant objectAtIndex:self.selected] objectForKey:@"address"]];
    [item1 setResturantParking:[[self.fetchedResturant objectAtIndex:self.selected] objectForKey:@"parking"]];
    [item1 setResturantWifi:[[self.fetchedResturant objectAtIndex:self.selected] objectForKey:@"wifi"]];
    [item1 setResturantChild:[[self.fetchedResturant objectAtIndex:self.selected] objectForKey:@"child"]];
    PFGeoPoint *location = [[self.fetchedResturant objectAtIndex:self.selected] objectForKey:@"coordinate"];
    CLLocation * myLocation=[[CLLocation alloc]initWithLatitude:location.latitude longitude:location.longitude];
    [item1 setResturantLocation:myLocation];
//    [item1 setResturantObjectId:[[self.fetchedResturant objectAtIndex:self.selected] objectId]];
//    Latitude = location.latitude;
//    Longitude = location.longitude;
//    CLLocationCoordinate2D* location=(__bridge CLLocationCoordinate2D *)([[self.fetchedResturant objectAtIndex:self.selected] objectForKey:@"coordinate"]);
//    CLLocationDegrees* Latitude = [[[self.fetchedResturant objectAtIndex:self.selected] objectForKey:@"address"].latitude];
//    Longitude = [[object objectForKey:@"Location"].longitude];
//    
//    
//    [item1 setResturantLocation:location];
   // resturant.test=[self.resturantName objectAtIndex:self.selected];
    }
    else if ([segue.identifier isEqualToString:@"goToSearchResult"])
    {
        searchListViewController* searchController=(searchListViewController*)segue.destinationViewController;
        if (!((searchFilterView*)searchView).resturantName.text.length>0) {
            [searchController setRestCost:self.restCost];
            [searchController setRestDiscount:self.restDiscount];
            [searchController setRestDistance:self.restDistance];
            [searchController setRestType:self.restType];
            [searchController setRestName:@""];
        }
        else{
        [searchController setRestName:((searchFilterView*)searchView).resturantName.text];
        }
        
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)sideMenuAction:(id)sender {
    
    if(!isMenuOn){
        isMenuOn=YES;
        
        [UIView animateWithDuration:0.3 animations:^{
            self.collectionList.transform=CGAffineTransformMakeTranslation(-self.collectionList.frame.size.width/2, 0);
        } completion:^(BOOL finished) {
            
        }];
        NSLog(@"open");
        userBtn.userInteractionEnabled=NO;
        self.collectionList.userInteractionEnabled=NO;
        filterBtn.userInteractionEnabled=NO;
        
    }
    else{
        isMenuOn=NO;
        [UIView animateWithDuration:0.3 animations:^{
            self.collectionList.transform=CGAffineTransformMakeTranslation(0, 0);
        } completion:^(BOOL finished) {
            
        }];
        NSLog(@"close");
        userBtn.userInteractionEnabled=YES;
        self.collectionList.userInteractionEnabled=YES;
        filterBtn.userInteractionEnabled=YES;
        
    }
    
}
- (IBAction)filterButtonClicked:(id)sender {
    [((searchFilterView*)searchView).resturantName resignFirstResponder];
    ((searchFilterView*)searchView).resturantName.text=@"";
    if (!isFilterOn) {
        isFilterOn=YES;
        [UIView animateWithDuration:0.4 animations:^{
            searchView.transform=CGAffineTransformMakeTranslation(0, 0);
        }];
        menuBtn.userInteractionEnabled=NO;
    }
    else
    {
        isFilterOn=NO;
        [UIView animateWithDuration:0.4 animations:^{
            searchView.transform=CGAffineTransformMakeTranslation(0, -searchView.frame.size.height);
        }];
        menuBtn.userInteractionEnabled=YES;
    }
    
}
- (NSUInteger)numberOfItemsInPickerView:(AKPickerView *)pickerView
{
    if (pickerView==self.resturantTypePickerView) {
        return [self.resturantTypeTitles count];

    }
    if (pickerView==self.resturantCostLevelPickerView) {
        return [self.resturantCostLevelTitles count];
        
    }
    if (pickerView==self.resturantDiscountPickerView) {
        return [self.resturantDiscountTitles count];
        
    }

    else
        return 0;
}

- (NSString *)pickerView:(AKPickerView *)pickerView titleForItem:(NSInteger)item
{
    if (pickerView==self.resturantTypePickerView) {
        return self.resturantTypeTitles[item];
        
    }
    if (pickerView==self.resturantCostLevelPickerView) {
        return self.resturantCostLevelTitles[item];
        
    }
    if (pickerView==self.resturantDiscountPickerView) {
        return self.resturantDiscountTitles[item];
        
    }
    else
        return 0;
}


#pragma mark - AKPickerViewDelegate

- (void)pickerView:(AKPickerView *)pickerView didSelectItem:(NSInteger)item
{
    if (pickerView==self.resturantTypePickerView) {
        NSLog(@"%@", self.resturantTypeTitles[item]);
        self.restType= self.resturantTypeTitles[item];

    }
    if (pickerView==self.resturantCostLevelPickerView) {
        NSLog(@"%@", self.resturantCostLevelTitles[item]);
        self.restCost= self.resturantCostLevelTitles[item];
    }
    if (pickerView==self.resturantDiscountPickerView) {
        NSLog(@"%@", self.resturantDiscountTitles[item]);
        self.restDiscount= self.resturantDiscountTitles[item];
       // NSLog(@"%@",((searchFilterView*)searchView).resturantDistance.titleLabel.text);
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // Too noisy...
    // NSLog(@"%f", scrollView.contentOffset.x);
}
-(void)searchResturantList:(UIButton*)sender
{
    self.restDistance=[((searchFilterView*)searchView).resturantDistance.titleLabel.text intValue];

    [self performSegueWithIdentifier:@"goToSearchResult" sender:self];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (((searchFilterView*)searchView).resturantName.text.length>0 ) {
        NSLog(@"*************");
        ((searchFilterView*)searchView).increaseDistanceBtn.userInteractionEnabled=NO;
        ((searchFilterView*)searchView).decreaseDistanceBtn.userInteractionEnabled=NO;
        self.resturantCostLevelPickerView.userInteractionEnabled=NO;
        self.resturantTypePickerView.userInteractionEnabled=NO;
        self.resturantDiscountPickerView.userInteractionEnabled=NO;
   
    }
    if (((searchFilterView*)searchView).resturantName.text.length==0 ) {
        NSLog(@"&&&&&&&&&&&&&&&");
        self.resturantCostLevelPickerView.userInteractionEnabled=YES;
        self.resturantTypePickerView.userInteractionEnabled=YES;
        self.resturantDiscountPickerView.userInteractionEnabled=YES;
        ((searchFilterView*)searchView).increaseDistanceBtn.userInteractionEnabled=YES;
        ((searchFilterView*)searchView).decreaseDistanceBtn.userInteractionEnabled=YES;
        
    }
    [textField resignFirstResponder];
    return YES;
}
-(void)userBtnClicked:(UIButton*)sender
{
    [self performSegueWithIdentifier:@"goToUserPage" sender:self];
}

-(void)buttonClicked:(UIButton*)sender
{
    if ([sender.titleLabel.text isEqualToString:@"درباره ما"]) {
        NSLog(@"btnClicked");
        isMenuOn=NO;
        [UIView animateWithDuration:0.1 animations:^{
            self.collectionList.transform=CGAffineTransformMakeTranslation(0, 0);
            menuBtn.userInteractionEnabled=NO;


        } completion:^(BOOL finished) {
            aboutUsView.alpha=1;
            [aboutUsView addGestureRecognizer:tapOnView];

        }];

    }
    else if ([sender.titleLabel.text isEqualToString:@"پستا"]) {
        NSLog(@"پستا");
        isMenuOn=NO;
        [UIView animateWithDuration:0.1 animations:^{
            self.collectionList.transform=CGAffineTransformMakeTranslation(0, 0);
            //            self.collectionList.userInteractionEnabled=YES;
            menuBtn.userInteractionEnabled=NO;
        } completion:^(BOOL finished) {
            pastaaView.alpha=1;
            [pastaaView addGestureRecognizer:tapOnView];
        }];
    }
    else if ([sender.titleLabel.text isEqualToString:@"خروج"]) {
        isMenuOn=NO;
        [UIView animateWithDuration:0.1 animations:^{
            self.collectionList.transform=CGAffineTransformMakeTranslation(0, 0);
            //            self.collectionList.userInteractionEnabled=YES;
            menuBtn.userInteractionEnabled=NO;
        } completion:^(BOOL finished) {
            [PFUser logOut];
            [self dismissViewControllerAnimated:YES completion:^{
                
            }];
            

        }];
        
    }
    
}
-(void)tapOnPage:(UITapGestureRecognizer*)sender
{
    menuBtn.userInteractionEnabled=YES;
    filterBtn.userInteractionEnabled=YES;
    userBtn.userInteractionEnabled=YES;
    self.collectionList.userInteractionEnabled=YES;
    pastaaView.alpha=0;
    aboutUsView.alpha=0;
    [pastaaView removeGestureRecognizer:tapOnView];
    [aboutUsView removeGestureRecognizer:tapOnView];
}
@end
