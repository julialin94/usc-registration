//
//  FilterCourseViewController.m
//  USC Registration
//
//  Created by Vincent Ho on 2/24/15.
//  Copyright (c) 2015 HoLi. All rights reserved.
//

#import "FilterCourseViewController.h"

@interface FilterCourseViewController ()

@end

@implementation FilterCourseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.delegate filteredWithCriteria:nil];
}

@end
