//
//  TabViewController.m
//  pastaa
//
//  Created by Amin on 3/9/15.
//  Copyright (c) 2015 Reza Sazegarnezhad. All rights reserved.
//

#import "TabViewController.h"

@interface TabViewController ()

@end

@implementation TabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    UIButton* menuBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0,118/3, 87/2)];
    menuBtn.layer.cornerRadius=25;
    [menuBtn setBackgroundImage:[UIImage imageNamed:@"tik.png"] forState:UIControlStateNormal];
    
    UIBarButtonItem *btnSample = [[UIBarButtonItem alloc] initWithCustomView:menuBtn];
    [menuBtn addTarget:self action:@selector(gotoReservePage:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = btnSample;
    
    
    
}

-(void)gotoReservePage:(UIButton*)sender{
    [self performSegueWithIdentifier:@"reserveSegue" sender:self];
    
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
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    addReserveViewController* reserve=segue.destinationViewController;
    reserve.ResturantObject=self.restObject;
}
@end
