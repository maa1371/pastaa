//
//  resturantGalleryViewController.m
//  pastaa
//
//  Created by Amin on 3/9/15.
//  Copyright (c) 2015 Reza Sazegarnezhad. All rights reserved.
//

#import "resturantGalleryViewController.h"
#import "ILTranslucentView.h"
@interface resturantGalleryViewController ()


@end

@implementation resturantGalleryViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    //self.scrollView.hidden=YES;
    ILTranslucentView *translucentView = [[ILTranslucentView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:translucentView]; //that's it :)
    
    //optional:
    translucentView.translucentAlpha = 0.6;
    translucentView.translucentStyle = UIBarStyleDefault;
    translucentView.translucentTintColor = [UIColor clearColor];
    translucentView.backgroundColor = [UIColor clearColor];
    [self.view sendSubviewToBack:translucentView];
    [self.view sendSubviewToBack:self.backgroundImage];
    self.resturantChildLabel.text=[NSString stringWithFormat:@"محل تفریح برای کودکان %@",self.child];
    self.resturantParkingLabel.text=[NSString stringWithFormat:@"محل پارک %@",self.parking];
    self.resturantWifiLabel.text=[NSString stringWithFormat:@"وایرلس %@",self.wifi];

    
    self.imagesData = @[@"3.jpg", @"5.jpg", @"6.jpg"];

    [self setupScrollViewImages];
    self.scrollView.delegate=self;
    self.scrollView.bounds=self.wrapper.bounds;
    
    self.customPageControl= [[TAPageControl alloc] initWithFrame:CGRectMake(0, self.wrapper.bounds.size.height - 50, CGRectGetWidth(self.wrapper.frame), 40)];
   // self.customPageControl.center=CGPointMake(self.wrapper.center.x, self.wrapper.frame.size.height);
    self.customPageControl.numberOfPages   = self.imagesData.count;
    // Custom dot view with image
    self.customPageControl.dotImage        = [UIImage imageNamed:@"dotInactive"];
    self.customPageControl.currentDotImage = [UIImage imageNamed:@"dotActive"];
    
    [self.wrapper addSubview:self.customPageControl];
    [self.wrapper bringSubviewToFront:self.customPageControl];
    // Set up the image you want to scroll & zoom and add it to the scroll view
    
    
    // Set up the page control
    
    
    // Set up the array to hold the views for each page
    
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
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    [self.scrollView sizeToFit];
    self.scrollView.layer.masksToBounds=YES;
    self.scrollView.contentSize = CGSizeMake(self.wrapper.frame.size.width * self.imagesData.count , CGRectGetHeight(self.wrapper.frame));
    
}


#pragma mark - ScrollView delegate



- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger pageIndex = scrollView.contentOffset.x / self.wrapper.frame.size.width;
    
        self.customPageControl.currentPage = pageIndex;
   
    
    
}


// Example of use of delegate for second scroll view to respond to bullet touch event
//- (void)TAPageControl:(TAPageControl *)pageControl didSelectPageAtIndex:(NSInteger)index
//{
//    NSLog(@"Bullet index %ld", (long)index);
//    [self.scrollView2 scrollRectToVisible:CGRectMake(CGRectGetWidth(self.scrollView2.frame) * index, 0, CGRectGetWidth(self.scrollView2.frame), CGRectGetHeight(self.scrollView2.frame)) animated:YES];
//}



-(void)setupScrollViewImages
{
    
    [self.imagesData enumerateObjectsUsingBlock:^(NSString *imageName, NSUInteger idx, BOOL *stop) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(_wrapper.bounds) * idx, 0, self.wrapper.frame.size.width, CGRectGetHeight(_scrollView.frame))];
        imageView.contentMode = UIViewContentModeScaleToFill;
        imageView.image = [UIImage imageNamed:imageName];
        [_scrollView addSubview:imageView];
    }];
    
//    for (int i=0; i<[self.imagesData count]; i++) {
//        UIImageView *imageView = [[UIImageView alloc]init];
//        imageView.frame=CGRectMake(self.scrollView.frame.size.width * i , self.scrollView.frame.origin.y, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
//        imageView.contentMode = UIViewContentModeScaleToFill;
//          imageView.image = [self.imagesData objectAtIndex:i];
//          [_scrollView addSubview:imageView];
//
//        
//        
//    }
    
    
}
@end
