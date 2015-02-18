//
//  Course.m
//  USC Registration
//
//  Created by hovincen on 2/17/15.
//  Copyright (c) 2015 HoLi. All rights reserved.
//

#import "Course.h"
#import "Section.h"
@implementation Course

-(id)initWithDictionary:(NSDictionary *)dict{
    self = [super init];
    self.sections = [[NSMutableArray alloc] init];
    self.courseID = [[dict objectForKey:@"COURSE_ID"] integerValue];
    self.diversity = [@"Y" isEqualToString:[dict objectForKey:@"DIVERSITY_FLAG"]]? YES: NO;
    self.effectiveTermCode = [dict objectForKey:@"EFFECTIVE_TERM_CODE"];
    self.maxUnits = [[dict objectForKey:@"MAX_UNITS"] integerValue];
    self.minUnits = [[dict objectForKey:@"MIN_UNITS"] integerValue];
    self.sisCourseID = [dict objectForKey:@"SIS_COURSE_ID"];
    self.courseDescription = [dict objectForKey:@"DESCRIPTION"];
    self.title = [dict objectForKey:@"TITLE"];
    for (NSDictionary * section in [dict objectForKey:@"V_SOC_SECTION"]) {
        Section * s = [[Section alloc] initWithDictionary:section];
        [self add:s];
    }
    return self;
}
-(void)add:(id)object{
    [self.sections addObject:object];
}
@end
