//
//  Section.h
//  USC Registration
//
//  Created by hovincen on 2/17/15.
//  Copyright (c) 2015 HoLi. All rights reserved.
//

#import "Data.h"
#import "Session.h"
@interface Section : Data

@property (nonatomic, strong) NSString * addDate;
@property (nonatomic, strong) NSString * beginTime;
@property (nonatomic, strong) NSString * cancelDate;
@property (nonatomic, strong) NSString * courseID;
@property (nonatomic, strong) NSString * day;
@property (nonatomic, strong) NSString * endTime;
@property (nonatomic, strong) NSString * instructor;
@property (nonatomic, strong) NSString * location;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * publishFlag;
@property (nonatomic, strong) NSString * publishSectionFlag;
@property (nonatomic, strong) NSString * section;
//@property (nonatomic, strong) Session * session;
@property (nonatomic, strong) NSString * sisCourseID;
@property (nonatomic, strong) NSString * termCode;
@property (nonatomic, strong) NSString * type;
@property (nonatomic) NSInteger unitCode;
@property (nonatomic) NSInteger registered;
@property (nonatomic) NSInteger seats;
//@property (nonatomic, strong) NSMutableArray * arrayOfDays;
@property (nonatomic, strong) NSString * sessionCode;
@end
