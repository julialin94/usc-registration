//
//  ViewController.h
//  USC Registration
//
//  Created by hovincen on 2/8/15.
//  Copyright (c) 2015 HoLi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RequestParentViewController.h"
@interface ViewController : RequestParentViewController<NSURLConnectionDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *animatedLogoImageView;
@property (weak, nonatomic) IBOutlet UIView *logoViewBackground;

@property (weak, nonatomic) IBOutlet UILabel *loadingLabel;
@property (nonatomic) BOOL shownBefore;
- (IBAction)goButtonAction:(id)sender;

@end

