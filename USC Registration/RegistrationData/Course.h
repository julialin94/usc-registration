//
//  Course.h
//  USC Registration
//
//  Created by hovincen on 2/17/15.
//  Copyright (c) 2015 HoLi. All rights reserved.
//

#import "Data.h"
@interface Course : Data
@property (nonatomic, strong) NSString * courseDescription;
@property (nonatomic) NSInteger courseID;
@property (nonatomic) BOOL diversity;
@property (nonatomic, strong) NSString * effectiveTermCode;
@property (nonatomic) NSInteger maxUnits;
@property (nonatomic) NSInteger minUnits;
@property (nonatomic, strong) NSMutableArray * sections;
@property (nonatomic, strong) NSString * sisCourseID;
@property (nonatomic, strong) NSString * title;
@property (nonatomic) BOOL downloaded;
-(void)downloadData;
@end
