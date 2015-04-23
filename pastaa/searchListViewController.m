//
//  searchListViewController.m
//  pastaa
//
//  Created by Helia Taghavi on 4/6/15.
//  Copyright (c) 2015 Reza Sazegarnezhad. All rights reserved.
//

#import "searchListViewController.h"
#import "TabViewController.h"
#import "resturantMainViewController.h"
#import <Parse/Parse.h>
#import "MBProgressHUD.h"

@interface searchListViewController ()
{
    MBProgressHUD *hud;
    
}
@end

@implementation searchListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"دریافت اطلاعات ...";
    [hud show:YES];
    

    self.resturantListPic=[[NSMutableArray alloc]init];
    
    self.resturantAdType=[[NSMutableArray alloc]init];
    self.resturantName=[[NSMutableArray alloc]init];
    
    self.fetchedResturant=[[NSArray alloc]init];
    self.resturantObjectId=[[NSMutableArray alloc]init];
    
//    PFQuery *query = [PFQuery queryWithClassName:@"resturant"];
//    //[query fromLocalDatastore];
//
//    
//    if (self.restName.length==0) {
//        NSLog(@"bye");
//        [PFGeoPoint geoPointForCurrentLocationInBackground:^(PFGeoPoint *geoPoint, NSError *error) {
//            if (!error) {
//                // Create a query for places
//                //PFQuery *query = [PFQuery queryWithClassName:@"PlaceObject"];
//                // Interested in locations near user.
//                NSLog(@"&&&&&&&& %ld",(long)self.restDistance);
//                [query whereKey:@"coordinate" nearGeoPoint:geoPoint withinKilometers:self.restDistance];
//                //
//                //            // Limit what could be a lot of points.
//                query.limit = 20;
//                // Final list of objects
//                //            NSArray* test=[query findObjects];
//                //            NSLog(@"test is :%@",test);
//                NSLog(@"GOPoint********************** %@",geoPoint);
//                
//                
//                
//                if (![self.restCost isEqualToString:@"مهم نیست"]) {
//                    [query whereKey:@"costLevel" equalTo:self.restCost];
//                }
//                if (![self.restDiscount isEqualToString:@"مهم نیست"]) {
//                    [query whereKey:@"takhfif" containsString:@"٪"];
//                }
//                if (![self.restType isEqualToString:@"مهم نیست"]) {
//                    [query whereKey:@"type" equalTo:self.restType];
//                }
//                
//                
//                self.fetchedResturant=[query findObjects];
//                
//                [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//                    if (!error) {
//                        
//                        // NSLog(@"Successfully retrieved: %@", objects);
//                        
//                        self.fetchedResturant=objects;
//                        
//                        for (int i=0; i<[self.fetchedResturant count]; i++) {
//                            
//                            NSNumber *adT;
//                            NSString *name;
//                            NSString *objectId;
//                            PFFile *image;
//                            
//                            adT = [[self.fetchedResturant objectAtIndex:i] objectForKey:@"adType"];
//                            name= [[self.fetchedResturant objectAtIndex:i] objectForKey:@"Name"];
//                            objectId= [[self.fetchedResturant objectAtIndex:i] objectId];
//                            image= (PFFile *)[[self.fetchedResturant objectAtIndex:i] objectForKey:@"rAdImg"];
//                            
//                            [self.resturantAdType addObject:adT];
//                            [self.resturantName addObject:name];
//                            [self.resturantListPic addObject:[UIImage imageWithData:image.getData]];
//                            [self.resturantObjectId addObject:objectId];
//                            
//                        }
//                        
//                        [hud hide:YES];
//                        
//                        [self.searchCollectionView reloadData];
//                        
//                        //  [PFObject pinAllInBackground:objects];
//                        
//                    } else {
//                        NSString *errorString = [[error userInfo] objectForKey:@"error"];
//                        NSLog(@"Error: %@", errorString);
//                    }
//                }];
//                
//                
//                
//                
//                
//                
//                
//            }
//        }];
//    }
//    else{
//        NSLog(@"hiiiiiiiii");
//        [query whereKey:@"Name" equalTo:self.restName];
//        self.fetchedResturant=[query findObjects];
//        
//        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//            if (!error) {
//                
//                // NSLog(@"Successfully retrieved: %@", objects);
//                
//                self.fetchedResturant=objects;
//                
//                for (int i=0; i<[self.fetchedResturant count]; i++) {
//                    
//                    NSNumber *adT;
//                    NSString *name;
//                    NSString *objectId;
//                    PFFile *image;
//                    
//                    adT = [[self.fetchedResturant objectAtIndex:i] objectForKey:@"adType"];
//                    name= [[self.fetchedResturant objectAtIndex:i] objectForKey:@"Name"];
//                    objectId= [[self.fetchedResturant objectAtIndex:i] objectId];
//                    image= (PFFile *)[[self.fetchedResturant objectAtIndex:i] objectForKey:@"rAdImg"];
//                    
//                    [self.resturantAdType addObject:adT];
//                    [self.resturantName addObject:name];
//                    [self.resturantListPic addObject:[UIImage imageWithData:image.getData]];
//                    [self.resturantObjectId addObject:objectId];
//                    
//                }
//                
//                [hud hide:YES];
//                
//                [self.searchCollectionView reloadData];
//                
//                //  [PFObject pinAllInBackground:objects];
//                
//            } else {
//                NSString *errorString = [[error userInfo] objectForKey:@"error"];
//                NSLog(@"Error: %@", errorString);
//            }
//        }];
//    }

    
    
    
//    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//        if (!error) {
//
//           // NSLog(@"Successfully retrieved: %@", objects);
//
//            self.fetchedResturant=objects;
//
//            for (int i=0; i<[self.fetchedResturant count]; i++) {
//                
//                NSNumber *adT;
//                NSString *name;
//                NSString *objectId;
//                PFFile *image;
//                
//                adT = [[self.fetchedResturant objectAtIndex:i] objectForKey:@"adType"];
//                name= [[self.fetchedResturant objectAtIndex:i] objectForKey:@"Name"];
//                objectId= [[self.fetchedResturant objectAtIndex:i] objectId];
//                image= (PFFile *)[[self.fetchedResturant objectAtIndex:i] objectForKey:@"rAdImg"];
//                
//                [self.resturantAdType addObject:adT];
//                [self.resturantName addObject:name];
//                [self.resturantListPic addObject:[UIImage imageWithData:image.getData]];
//                [self.resturantObjectId addObject:objectId];
//                
//            }
//            
//            
//            [self.searchCollectionView reloadData];
//            
//            //  [PFObject pinAllInBackground:objects];
//            
//        } else {
//            NSString *errorString = [[error userInfo] objectForKey:@"error"];
//            NSLog(@"Error: %@", errorString);
//        }
//    }];
    
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{
    [self.resturantAdType removeAllObjects];
    
    //[query fromLocalDatastore];
    
    
    
    if (self.restName.length==0) {
        PFQuery *query = [PFQuery queryWithClassName:@"resturant"];
        NSLog(@"bye");
        [PFGeoPoint geoPointForCurrentLocationInBackground:^(PFGeoPoint *geoPoint, NSError *error) {
            if (!error) {
                // Create a query for places
                //PFQuery *query = [PFQuery queryWithClassName:@"PlaceObject"];
                // Interested in locations near user.
                NSLog(@"&&&&&&&& %ld",(long)self.restDistance);
                [query whereKey:@"coordinate" nearGeoPoint:geoPoint withinKilometers:self.restDistance];
                //
                //            // Limit what could be a lot of points.
                query.limit = 20;
                // Final list of objects
                //            NSArray* test=[query findObjects];
                //            NSLog(@"test is :%@",test);
                NSLog(@"GOPoint********************** %@",geoPoint);
                
                
                
                if (![self.restCost isEqualToString:@"مهم نیست"]) {
                    [query whereKey:@"costLevel" equalTo:self.restCost];
                }
                if (![self.restDiscount isEqualToString:@"مهم نیست"]) {
                    [query whereKey:@"takhfif" containsString:@"٪"];
                }
                if (![self.restType isEqualToString:@"مهم نیست"]) {
                    [query whereKey:@"type" equalTo:self.restType];
                }
                
                
              //  self.fetchedResturant=[query findObjects];
                
                [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                    if (!error) {
                        
                        // NSLog(@"Successfully retrieved: %@", objects);
                        
                        self.fetchedResturant=objects;
                        
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
                        
                        [hud hide:YES];
                        
                        [self.searchCollectionView reloadData];
                        
                        //  [PFObject pinAllInBackground:objects];
                        
                    } else {
                        NSString *errorString = [[error userInfo] objectForKey:@"error"];
                        NSLog(@"Error: %@", errorString);
                    }
                }];
                
                
                
                
                
                
                
            }
        }];
    }
    else{
        PFQuery *query2 = [PFQuery queryWithClassName:@"resturant"];
       // NSLog(@"hiiiiiiiii, %@",self.restName);
      
        [self.restName stringByReplacingOccurrencesOfString:@"ی" withString:@"ي"];
       // [self.restName stringByReplacingOccurrencesOfString:@"ي" withString:@"ی"];
        
        
        [query2 whereKey:@"Name" equalTo:self.restName];
        
        //self.fetchedResturant=[query2 findObjects];
        
        [query2 findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (!error) {
               
                NSLog(@"object count :: %lu ",(unsigned long)[objects count]);
                
              //  NSLog(@"Successfully retrieved: %@", objects);

                
                self.fetchedResturant=objects;
                
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
                
                [hud hide:YES];
                
                [self.searchCollectionView reloadData];
                
                //  [PFObject pinAllInBackground:objects];
                
            } else {
                NSString *errorString = [[error userInfo] objectForKey:@"error"];
                NSLog(@"Error: %@", errorString);
            }
        }];
    }
    

    
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
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    //  NSLog(@"resturant count %lu",(unsigned long)[self.resturantAdType count]);
    return [self.resturantAdType count];
}


-(UICollectionViewCell*) collectionView:(UICollectionView *)collectionView
                 cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell* cell = [self.searchCollectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.backgroundView=[[UIImageView alloc]initWithImage:[self.resturantListPic objectAtIndex:indexPath.row]];
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //You may want to create a divider to scale the size by the way..
    CGSize cellSize;
    if ([[self.resturantAdType objectAtIndex:indexPath.row]integerValue]==1) {
        cellSize=CGSizeMake(self.searchCollectionView.frame.size.width/2-15, self.searchCollectionView.frame.size.height/3.8);
    }
    else
        cellSize=CGSizeMake(self.searchCollectionView.frame.size.width/2-5, self.searchCollectionView.frame.size.height/3.8);
    return cellSize;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    self.selected=indexPath.row;
    [self performSegueWithIdentifier:@"goToResturant" sender:self];
    
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"goToResturant"]) {
        
        TabViewController* resturant=(TabViewController*)segue.destinationViewController;
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
}
@end
