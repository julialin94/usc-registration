//
//  Term.h
//  USC Registration
//
//  Created by hovincen on 2/17/15.
//  Copyright (c) 2015 HoLi. All rights reserved.
//

#import "Data.h"
#import "School.h"
@interface Term : Data
@property (nonatomic, strong) NSString * commencementDate;
@property (nonatomic, strong) NSString * earlyRegistrationEndDate;
@property (nonatomic, strong) NSString * earlyRegistrationStartDate;
@property (nonatomic, strong) NSString * normalRegistrationEndDate;
@property (nonatomic, strong) NSString * preregistrationEndDate;
@property (nonatomic, strong) NSString * preregistrationStartDate;
@property (nonatomic, strong) NSString * termCode;
@property (nonatomic, strong) NSString * termDescription;
@property (nonatomic, strong) NSMutableArray * schools;
@property (nonatomic, strong) NSMutableArray * departments;
@property (nonatomic, strong) NSMutableArray * prefixedDepartments;

@end
