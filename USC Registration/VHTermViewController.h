//
//  VHTermViewController.h
//  USC Registration
//
//  Created by Vincent Ho on 2/11/15.
//  Copyright (c) 2015 HoLi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RequestParentViewController.h"
@interface VHTermViewController : RequestParentViewController
@property (weak, nonatomic) IBOutlet UILabel *schoolLabel;
@property (weak, nonatomic) IBOutlet UILabel *prefixLabel;
@property (weak, nonatomic) IBOutlet UILabel *departmentLabel;
@property (weak, nonatomic) IBOutlet UIView *menuView;
@property (strong, nonatomic) UIView *lineView;
@property (nonatomic) NSInteger index;
@property (nonatomic, strong) NSDictionary * term;
@property (nonatomic, strong) NSMutableArray * arrayOfLabels;
@property (nonatomic, strong) NSDictionary * schools;

@end
