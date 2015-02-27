//
//  ClassView.h
//  USC Registration
//
//  Created by Vincent Ho on 2/26/15.
//  Copyright (c) 2015 HoLi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Section.h"
@interface ClassView : UIView
@property (nonatomic, strong) Section * s;
@property (nonatomic) CGFloat width;
- (instancetype)initWithSection:(Section *)section andWidth:(CGFloat) width;
@end
