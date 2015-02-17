//
//  ViewController.h
//  USC Registration
//
//  Created by hovincen on 2/8/15.
//  Copyright (c) 2015 HoLi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "RequestParentViewController.h"
@interface ViewController : RequestParentViewController<NSURLConnectionDelegate>
@property (nonatomic, strong) NSDictionary * selectedTerm;
@property (weak, nonatomic) IBOutlet UIImageView *animatedLogoImageView;
@property (weak, nonatomic) IBOutlet UIView *logoViewBackground;

@property (weak, nonatomic) IBOutlet UILabel *loadingLabel;
@property (nonatomic) BOOL shownBefore;
@property (nonatomic) BOOL buttonClicked;
@property (nonatomic, strong) MBProgressHUD * progressHUD;
- (IBAction)goButtonAction:(id)sender;

@end

