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
#import "Term.h"
@interface ViewController : UIViewController<NSURLConnectionDelegate>
@property (nonatomic, strong) AppDelegate * appDelegate;
@property (nonatomic, strong) NSMutableData *responseData;
@property (nonatomic, strong) Term * term;
@property (nonatomic, strong) NSDictionary * selectedTerm;
@property (weak, nonatomic) IBOutlet UIImageView *animatedLogoImageView;
@property (weak, nonatomic) IBOutlet UIView *logoViewBackground;

@property (weak, nonatomic) IBOutlet UILabel *loadingLabel;
@property (nonatomic) BOOL shownBefore;
@property (nonatomic) BOOL buttonClicked;
- (IBAction)goButtonAction:(id)sender;

@end

