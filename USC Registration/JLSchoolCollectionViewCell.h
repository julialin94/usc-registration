//
//  JLSchoolCollectionViewCell.h
//  USC Registration
//
//  Created by Julia Lin on 2/23/15.
//  Copyright (c) 2015 HoLi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JLSchoolCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *schoolIconView;
@property (weak, nonatomic) IBOutlet UILabel *schoolLabel;
@property (weak, nonatomic) IBOutlet UIView *circleView;

@end
