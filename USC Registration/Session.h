//
//  Session.h
//  USC Registration
//
//  Created by hovincen on 2/17/15.
//  Copyright (c) 2015 HoLi. All rights reserved.
//

#import "Data.h"

@interface Session : Data

@property (nonatomic, strong) NSString * classBeginDate;
@property (nonatomic, strong) NSString * classEndDate;
@property (nonatomic, strong) NSString * finalExamBeginDate;
@property (nonatomic, strong) NSString * finalExamEndDate;
@property (nonatomic, strong) NSString * lastAddDropDate;
@property (nonatomic, strong) NSString * sessionCode;
@property (nonatomic, strong) NSNumber * sessionID;
@property (nonatomic, strong) NSString * stopDate;
@property (nonatomic, strong) NSString * termCode;
@property (nonatomic, strong) NSString * withdrawWWDate;
@end
