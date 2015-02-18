//
//  School.h
//  USC Registration
//
//  Created by hovincen on 2/17/15.
//  Copyright (c) 2015 HoLi. All rights reserved.
//

#import "Data.h"

@interface School : Data

@property (nonatomic, strong) NSMutableArray * departments;
@property (nonatomic, strong) NSString * schoolCode;
@property (nonatomic, strong) NSString * schoolDescription;
@end
