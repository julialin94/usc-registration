//
//  FilterSectionViewController.m
//  USC Registration
//
//  Created by Vincent Ho on 2/24/15.
//  Copyright (c) 2015 HoLi. All rights reserved.
//

#import "FilterSectionViewController.h"

@interface FilterSectionViewController ()

@end

@implementation FilterSectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.delegate filteredWithCriteria:nil];
}
@end
