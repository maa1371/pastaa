//
//  MenuViewController.m
//  pastaa
//
//  Created by Mohammad Hasan Ansari on 12/23/1393 AP.
//  Copyright (c) 1393 AP Reza Sazegarnezhad. All rights reserved.
//

#import "MenuViewController.h"
#import <Parse/Parse.h>
#import "TemplateCell.h"
#import "MBProgressHUD.h"
#import "ILTranslucentView.h"

@interface MenuViewController ()
{
    MBProgressHUD *hud;

}
@end

@implementation MenuViewController
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
    self.menuTable.bounces = YES;

    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    
    hud.labelText = @"دریافت اطلاعات ...";
   hud.labelFont    =[UIFont fontWithName:@"W_koodak" size:16];

    [hud show:YES];
    
    
//    NSLog(@"resturant ID:%@",self.ResturantId);
    
    PFObject *iObj=self.ResturantObject;

    self.nameArray=[[NSMutableArray alloc]init];
    self.priceArray=[[NSMutableArray alloc]init];
    self.ingredientArray=[[NSMutableArray alloc]init];
    self.imageArray=[[NSMutableArray alloc]init];
    self.categoryArray=[[NSMutableArray alloc]init];


    
    PFQuery *query = [PFQuery queryWithClassName:@"menu"]; //1
    
    [query whereKey:@"parent" equalTo:iObj];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {//4
        if (!error) {
            
            NSNumber *cost;
            NSString *name;
            NSString *ingredient;
            NSString *category;
            PFFile *image;
            for (int i=0; i <[objects count]; i++) {
                cost = [[objects objectAtIndex:i] objectForKey:@"cost"];
                NSLog(@"cost %@",cost);
                
                name= [[objects objectAtIndex:i] objectForKey:@"name"];
                image= (PFFile *)[[objects objectAtIndex:i] objectForKey:@"rSearchImg"];
                ingredient=[[objects objectAtIndex:i] objectForKey:@"description"];
                category=[[objects objectAtIndex:i] objectForKey:@"category"];
                [self.imageArray addObject:[UIImage imageWithData:image.getData]];
                [self.nameArray addObject:(NSString*)name];
                [self.ingredientArray addObject:ingredient];
                [self.priceArray addObject:cost];
                [self.categoryArray addObject:category];
                [self.imageArray addObject:[UIImage imageWithData:image.getData]];
                [self.nameArray addObject:(NSString*)name];
                [self.ingredientArray addObject:ingredient];
                [self.priceArray addObject:cost];
                
//                NSLog(@"cost in array %ld",(long)[[self.priceArray objectAtIndex:i] integerValue]);
                
                [self.categoryArray addObject:category];
                
               // NSLog(@"%@",self.categoryArray);


            }
            [self.menuTable reloadData];
            
            [hud hide:YES];
            
            NSLog(@"ingrediant %lu",(unsigned long)self.ingredientArray.count);
            
            //NSLog(@"Successfully retrieved: %@", objects);
            


            
            NSLog(@"%@",self.nameArray);
            
            //  [hud hide:YES];
        } else {
            NSString *errorString = [[error userInfo] objectForKey:@"error"];
            NSLog(@"Error: %@", errorString);
        }
        [self.menuTable reloadData];
    }];
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.nameArray count];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    if (indexPath.row % 2 == 1)
    {
    TemplateCell * cell = (TemplateCell *)[tableView dequeueReusableCellWithIdentifier:@"myCell"];
    if (cell == nil) {
        NSArray * topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"TemplateCell" owner:self options:nil];
        
        
        
        for(id currentObject in topLevelObjects)
        {
            if([currentObject isKindOfClass:[UITableViewCell class]])
            {
                cell = (TemplateCell *)currentObject;
//                cell.contentView.layer.borderColor=[[UIColor blackColor]CGColor];
//                cell.contentView.layer.borderWidth=2;
                UIView * additionalSeparator = [[UIView alloc] initWithFrame:CGRectMake(5,cell.frame.size.height-3,cell.frame.size.width-10,2)];
                additionalSeparator.backgroundColor = [UIColor clearColor];
                [cell addSubview:additionalSeparator];
                if (self.imageArray.count >indexPath.row) {
                    [cell.foodImage.layer setMasksToBounds:YES];
                    cell.foodImage.layer.cornerRadius=cell.foodImage.frame.size.width/2;
                    cell.foodImage.image=[self.imageArray objectAtIndex:indexPath.row];
                }
                
                if (self.nameArray.count >indexPath.row) {
                    cell.foodName.textAlignment=NSTextAlignmentRight;
                    cell.foodName.text=[self.nameArray objectAtIndex:indexPath.row];
                }
                if (self.ingredientArray.count >indexPath.row) {
                    cell.foodIngredient.text=[self.ingredientArray objectAtIndex:indexPath.row];
                }
                if (self.priceArray.count*2 >indexPath.row) {
                    cell.foodPrice.text=[NSString stringWithFormat:@"%@",[self.priceArray objectAtIndex:indexPath.row]];
                }
                break;
            }
        }
    }
    else
    {
        UIView * additionalSeparator = [[UIView alloc] initWithFrame:CGRectMake(5,cell.frame.size.height-3,cell.frame.size.width-10,2)];
        additionalSeparator.backgroundColor = [UIColor clearColor];
        [cell addSubview:additionalSeparator];
        if (self.imageArray.count >indexPath.row) {
            [cell.foodImage.layer setMasksToBounds:YES];
            cell.foodImage.layer.cornerRadius=cell.foodImage.frame.size.width/2;
            cell.foodImage.image=[self.imageArray objectAtIndex:indexPath.row];
        }
        
        if (self.nameArray.count >indexPath.row) {
            cell.foodName.textAlignment=NSTextAlignmentRight;
            cell.foodName.text=[self.nameArray objectAtIndex:indexPath.row];
        }
        if (self.ingredientArray.count >indexPath.row) {
            cell.foodIngredient.text=[self.ingredientArray objectAtIndex:indexPath.row];
        }
        if (self.priceArray.count*2 >indexPath.row) {
            cell.foodPrice.text=[NSString stringWithFormat:@"%@",[self.priceArray objectAtIndex:indexPath.row]];
        }

    }
    
    
        return cell;
    }
    else {
        
        static NSString *CellIdentifier2 = @"Cell2";
        UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier2];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                           reuseIdentifier:CellIdentifier2];
        }
        cell.backgroundColor = [UIColor clearColor];
        return cell;
    }

    
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Remove seperator inset
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    // Prevent the cell from inheriting the Table View's margin settings
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    
    // Explictly set your cell's layout margins
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row % 2 == 1) {
        return 100.0;
    } else {
        return 2.0;
    }
}


@end
