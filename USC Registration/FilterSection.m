//
//  FilterSection.m
//  USC Registration
//
//  Created by Vincent Ho on 2/26/15.
//  Copyright (c) 2015 HoLi. All rights reserved.
//

#import "FilterSection.h"

@implementation FilterSection
-(instancetype)init{
    self = [super init];
    CGFloat width = [UIApplication sharedApplication].keyWindow.frame.size.width;
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 30)];
    label.text = @"Filter";
    label.textAlignment = NSTextAlignmentCenter;
    [self.scrollView addSubview:label];
    [self.backgroundButton addTarget:self action:@selector(hideFilter) forControlEvents:UIControlEventTouchUpInside];
    [self.closeButton addTarget:self action:@selector(hideFilter) forControlEvents:UIControlEventTouchUpInside];
    self.scrollView.clipsToBounds = NO;
    return self;
}
-(void)showFilter{
    [self show];
}
-(void)hideFilter{
    [self hide];
}

@end
