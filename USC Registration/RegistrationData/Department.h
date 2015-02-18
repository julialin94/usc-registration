//
//  Department.h
//  USC Registration
//
//  Created by hovincen on 2/17/15.
//  Copyright (c) 2015 HoLi. All rights reserved.
//

#import "Data.h"

@interface Department : Data
@property (nonatomic, strong) NSMutableArray * courses;
@property (nonatomic, strong) NSString * departmentCode;
@property (nonatomic, strong) NSString * departmentDescription;
@property (nonatomic, strong) NSString * schoolCode;
@end
