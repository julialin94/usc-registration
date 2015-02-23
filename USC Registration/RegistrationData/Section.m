//
//  Section.m
//  USC Registration
//
//  Created by hovincen on 2/17/15.
//  Copyright (c) 2015 HoLi. All rights reserved.
//

#import "Section.h"

@implementation Section

-(id)initWithDictionary:(NSDictionary *)dict{
    self = [super init];
    self.addDate = [dict objectForKey:@"ADD_DATE"];
    self.beginTime = [dict objectForKey:@"BEGIN_TIME"];
    self.cancelDate = [dict objectForKey:@"CANCEL_DATE"];
    self.courseID = [dict objectForKey:@"COURSE_ID"];
    NSString * str =[dict objectForKey:@"DAY"];
    if([str isKindOfClass:[NSNull class]])
        self.day = @"tba";
    else
        self.day = [dict objectForKey:@"DAY"];
    self.endTime = [dict objectForKey:@"END_TIME"];
    str =[dict objectForKey:@"INSTRUCTOR"];
    if([str isKindOfClass:[NSNull class]])
        self.instructor = @"TBA";
    else
        self.instructor = [dict objectForKey:@"INSTRUCTOR"];
    str =[dict objectForKey:@"LOCATION"];
    if([str isKindOfClass:[NSNull class]])
        self.location = @"TBA";
    else
        self.location = [dict objectForKey:@"LOCATION"];
    self.name = [dict objectForKey:@"NAME"];
    self.publishFlag = [dict objectForKey:@"PUBLISH_FLAG"];
    self.publishSectionFlag = [dict objectForKey:@"PUBLISH_SECTION_FLAG"];
    str =[dict objectForKey:@"REGISTERED"];
    if([str isKindOfClass:[NSNull class]])
        self.registered = 0;
    else
        self.registered = [[dict objectForKey:@"REGISTERED"] integerValue];
#pragma mark session class should be instantiated?
    str =[dict objectForKey:@"SESSION"];
    if([str isKindOfClass:[NSNull class]])
        self.sessionCode = @"0";
    else
        self.sessionCode = [dict objectForKey:@"SESSION"];
    self.seats = [[dict objectForKey:@"SEATS"] integerValue];
    self.section = [dict objectForKey:@"SECTION"];
    self.sisCourseID = [dict objectForKey:@"SIS_COURSE_ID"];
    self.termCode = [dict objectForKey:@"TERM_CODE"];
    self.type = [dict objectForKey:@"TYPE"];
    self.unitCode = [[dict objectForKey:@"UNIT_CODE"] integerValue];
    return self;
}
@end
