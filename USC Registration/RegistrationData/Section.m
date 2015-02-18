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
    self.day = [dict objectForKey:@"DAY"];
    self.endTime = [dict objectForKey:@"END_TIME"];
    self.instructor = [dict objectForKey:@"INSTRUCTOR"];
    self.location = [dict objectForKey:@"LOCATION"];
    self.name = [dict objectForKey:@"NAME"];
    self.publishFlag = [dict objectForKey:@"PUBLISH_FLAG"];
    self.publishSectionFlag = [dict objectForKey:@"PUBLISH_SECTION_FLAG"];
    self.registered = [[dict objectForKey:@"REGISTERED"] integerValue];
    self.seats = [[dict objectForKey:@"SEATS"] integerValue];
    self.section = [dict objectForKey:@"SECTION"];
    self.sisCourseID = [dict objectForKey:@"SIS_COURSE_ID"];
    self.termCode = [dict objectForKey:@"TERM_CODE"];
    self.type = [dict objectForKey:@"TYPE"];
    self.unitCode = [[dict objectForKey:@""] integerValue];
    
//    NSString * url = [NSString stringWithFormat:@"%@/sessions/%@", [self.appDelegate URL], [dict objectForKey:@"SESSION"]];
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
//    NSURLResponse *response;
//    NSData * data = [NSURLConnection sendSynchronousRequest:request
//                                          returningResponse:&response
//                                                      error:nil];
//    NSError * error;
//    dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
//    
//    self.session = [[Section alloc] initWithDictionary:section];
    return self;
}
@end
