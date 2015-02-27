//
//  VHCourseTableViewCell.m
//  USC Registration
//
//  Created by Vincent Ho on 2/20/15.
//  Copyright (c) 2015 HoLi. All rights reserved.
//

#import "VHCourseTableViewCell.h"

@implementation VHCourseTableViewCell

- (void)awakeFromNib {
    self.layer.shadowOffset = CGSizeMake(0, 0);
    self.layer.shadowOpacity = 0.2;
    self.layer.masksToBounds = NO;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
