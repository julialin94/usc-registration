//
//  VHCourseTableViewCell.h
//  USC Registration
//
//  Created by Vincent Ho on 2/20/15.
//  Copyright (c) 2015 HoLi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VHCourseTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *courseLabel;
@property (weak, nonatomic) IBOutlet UILabel *courseCodeLabel;
@property (weak, nonatomic) IBOutlet UIView *backView;

@end
