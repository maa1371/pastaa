//
//  searchFilterView.m
//  pastaa
//
//  Created by Helia Taghavi on 4/5/15.
//  Copyright (c) 2015 Reza Sazegarnezhad. All rights reserved.
//

#import "searchFilterView.h"

@implementation searchFilterView
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)increaseDistance:(id)sender {
    if ([self.resturantDistance.titleLabel.text intValue] < 10) {
        [self.resturantDistance setTitle:[NSString stringWithFormat:@"%i km",([self.resturantDistance.titleLabel.text intValue]+1)] forState:UIControlStateNormal];
    }
}
- (IBAction)decreaseDistance:(id)sender {
    if ([self.resturantDistance.titleLabel.text intValue] > 1) {
        [self.resturantDistance setTitle:[NSString stringWithFormat:@"%i km",([self.resturantDistance.titleLabel.text intValue]-1)] forState:UIControlStateNormal];
    }
}


@end
