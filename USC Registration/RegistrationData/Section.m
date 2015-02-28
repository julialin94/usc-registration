//
//  Section.m
//  USC Registration
//
//  Created by hovincen on 2/17/15.
//  Copyright (c) 2015 HoLi. All rights reserved.
//

#import "Section.h"

@implementation Section
-(NSString *)description{
    NSString * day = [self.day isEqualToString:@"tba"]? @"TBA" : self.day;
    NSString * time = [self.beginTime isEqualToString:@"TBA"]? @"TBA" : [NSString stringWithFormat:@"%@ to %@", self.beginTime, self.endTime];
    return [NSString stringWithFormat:@"%@ at %@ on %@. %ld units.", self.sisCourseID, time, day, self.unitCode];
}
- (void)encodeWithCoder:(NSCoder *)encoder {
    //Encode properties, other class variables, etc
    [encoder encodeObject:self.addDate forKey:@"addDate"];
    [encoder encodeObject:self.beginTime forKey:@"beginTime"];
    [encoder encodeObject:self.cancelDate forKey:@"cancelDate"];
    [encoder encodeObject:self.courseID forKey:@"courseID"];
    [encoder encodeObject:self.day forKey:@"day"];
    [encoder encodeObject:self.endTime forKey:@"endTime"];
    [encoder encodeObject:self.instructor forKey:@"instructor"];
    [encoder encodeObject:self.location forKey:@"location"];
    [encoder encodeObject:self.name forKey:@"name"];
    [encoder encodeObject:self.publishFlag forKey:@"publishFlag"];
    [encoder encodeObject:self.publishSectionFlag forKey:@"publishSectionFlag"];
    [encoder encodeObject:@(self.registered) forKey:@"registered"];
    [encoder encodeObject:@(self.seats) forKey:@"seats"];
    [encoder encodeObject:self.section forKey:@"section"];
    [encoder encodeObject:self.sisCourseID forKey:@"sisCourseID"];
    [encoder encodeObject:self.termCode forKey:@"termCode"];
    [encoder encodeObject:self.type forKey:@"type"];
    [encoder encodeObject:self.sessionCode forKey:@"sessionCode"];
    [encoder encodeObject:@(self.unitCode) forKey:@"unitCode"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if((self = [super init])) {
        //decode properties, other class vars
        self.addDate = [decoder decodeObjectForKey:@"addDate"];
        self.beginTime = [decoder decodeObjectForKey:@"beginTime"];
        self.cancelDate = [decoder decodeObjectForKey:@"cancelDate"];
        self.courseID = [decoder decodeObjectForKey:@"courseID"];
        self.day = [decoder decodeObjectForKey:@"day"];
        self.endTime = [decoder decodeObjectForKey:@"endTime"];
        self.instructor = [decoder decodeObjectForKey:@"instructor"];
        self.location = [decoder decodeObjectForKey:@"location"];
        self.name = [decoder decodeObjectForKey:@"name"];
        self.publishFlag = [decoder decodeObjectForKey:@"publishFlag"];
        self.publishSectionFlag = [decoder decodeObjectForKey:@"publishSectionFlag"];
        self.section = [decoder decodeObjectForKey:@"section"];
        self.sisCourseID = [decoder decodeObjectForKey:@"sisCourseID"];
        self.termCode = [decoder decodeObjectForKey:@"termCode"];
        self.type = [decoder decodeObjectForKey:@"type"];
        self.unitCode = [(NSString *)[decoder decodeObjectForKey:@"unitCode"] integerValue];
        self.registered = [(NSString *)[decoder decodeObjectForKey:@"registered"]integerValue];
        self.seats = [(NSString *)[decoder decodeObjectForKey:@"seats"] integerValue];
        self.sessionCode = [decoder decodeObjectForKey:@"sessionCode"];
    }
    return self;
}
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
    str =[dict objectForKey:@"TYPE"];
    if([str isKindOfClass:[NSNull class]])
        self.type = @"unknown";
    else
        self.type = [dict objectForKey:@"TYPE"];
    self.unitCode = [[dict objectForKey:@"UNIT_CODE"] integerValue];
    
    if (![self.beginTime isEqualToString:@"TBA"]) {
        NSDateFormatter * df = [[NSDateFormatter alloc] init];
        df.dateFormat = @"HH:mm";
        self.startTime = [df dateFromString:self.beginTime];
        self.finishTime = [df dateFromString:self.endTime];
    }
    return self;
}
@end
