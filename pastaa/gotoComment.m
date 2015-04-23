//
//  gotoComment.m
//  pastaa
//
//  Created by Mohammad Hasan Ansari on 12/25/1393 AP.
//  Copyright (c) 1393 AP Reza Sazegarnezhad. All rights reserved.
//

#import "gotoComment.h"

@implementation gotoComment

- (void)perform {
    UIViewController *sourceViewController = self.sourceViewController;
    UIViewController *destinationViewController = self.destinationViewController;
    
    // Add the destination view as a subview, temporarily
    
    // Transformation start scale
//n    destinationViewController.view.transform = CGAffineTransformMakeScale(0.05, 0.05);
    
    // Store original centre point of the destination view
   // CGPoint originalCenter = destinationViewController.view.center;
    // Set center to start point of the button
    //destinationViewController.view.center = CGPointMake(0, 0);
    
    [sourceViewController presentViewController:destinationViewController animated:YES completion:NULL]; // present VC
    destinationViewController.view.backgroundColor=[UIColor redColor];

    destinationViewController.view.transform=CGAffineTransformMakeTranslation(100, 20);
    
    [UIView animateWithDuration:0.5
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         // Grow!

                         //destinationViewController.view.transform = CGAffineTransformMakeScale(1.0, 1.0);
                        // destinationViewController.view.center = originalCenter;
                     }
                     completion:^(BOOL finished){
                         //[destinationViewController.view removeFromSuperview]; // remove from temp super view
//                        [sourceViewController presentViewController:destinationViewController animated:YES completion:NULL]; // present VC
//                         destinationViewController.view.backgroundColor=[UIColor redColor];
                    //     destinationViewController.view.transform=CGAffineTransformMakeTranslation(100, 20);
                         
                     }];
}


@end

