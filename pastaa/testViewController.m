//
//  testViewController.m
//  pastaa
//
//  Created by Helia Taghavi on 4/7/15.
//  Copyright (c) 2015 Reza Sazegarnezhad. All rights reserved.
//

#import "testViewController.h"

@interface testViewController ()

@end

@implementation testViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray * filterObjects = [[NSBundle mainBundle] loadNibNamed:@"filterView" owner:self options:nil];
    for(id currentObject in filterObjects)
    {
        if([currentObject isKindOfClass:[UIView class]])
        {
            searchView=(filterView*)currentObject;
            searchView.frame=self.view.bounds;
            
        }
    }
    [((filterView*)searchView).restNameBtn addTarget:self
                                              action:@selector(restNameBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:searchView];
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
-(void)restNameBtnClicked:(UIButton*)sender
{
    [UIView animateWithDuration:0.4 animations:^{
        ((filterView*)searchView).restNameConst.constant=150;
        
        ((filterView*)searchView).layoutIfNeeded;
    }];
}
@end
