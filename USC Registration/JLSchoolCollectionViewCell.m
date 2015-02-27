//
//  JLSchoolCollectionViewCell.m
//  USC Registration
//
//  Created by Julia Lin on 2/23/15.
//  Copyright (c) 2015 HoLi. All rights reserved.
//

#import "JLSchoolCollectionViewCell.h"

@implementation JLSchoolCollectionViewCell
-(void)awakeFromNib{
    self.circleView.backgroundColor = [UIColor lightTextColor];
    self.layer.shadowOffset = CGSizeMake(0, 0);
    self.layer.shadowOpacity = 0.2;
    self.layer.masksToBounds = NO;
    
    self.circleView.layer.cornerRadius = 50;
    [self.circleView.layer setBorderColor: [[UIColor blackColor] CGColor]];
    [self.circleView.layer setBorderWidth: 2.0];
//    self.backgroundColor = [UIColor colorWithRed:231.0/255.0 green:234.0/255.0 blue:224.0/225.0 alpha:1.0];
    self.backgroundColor = [UIColor lightTextColor];
}
@end
