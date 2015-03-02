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
-(NSString *)description{
    return [NSString stringWithFormat:@"%@ with Units %ld-%ld", self.sisCourseID, (long)self.minUnits, (long)self.maxUnits];
}
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

    
    return self;
}


-(void) downloadData{
    NSString * url = [NSString stringWithFormat:@"%@/Courses/%@/%ld", [self.appDelegate URL], self.appDelegate.term, (long)self.courseID];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSURLResponse *response;
    NSData * data = [NSURLConnection sendSynchronousRequest:request
                                          returningResponse:&response
                                                      error:nil];
    NSError * error;
    if (data == nil) {
        UIAlertView * av = [[UIAlertView alloc] initWithTitle:@"Connection error!" message:@"Please check your internet connection." delegate:nil cancelButtonTitle:@"OK!" otherButtonTitles:nil];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [av show];
        });
        return;
    }
    NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    self.downloaded = YES;
    if(error ) {
        NSLog(@"error: %@", error);
        UIAlertView * av = [[UIAlertView alloc] initWithTitle:@"Connection error!" message:@"Please check your internet connection." delegate:nil cancelButtonTitle:@"OK!" otherButtonTitles:nil];
        [av show];
    }
    else{
        self.sections = [[NSMutableArray alloc] init];
        for (NSDictionary * section in [dict objectForKey:@"V_SOC_SECTION"]) {
            Section * s = [[Section alloc] initWithDictionary:section];
            [self add:s];
        }
    }
}


-(void)add:(id)object{
    [self.sections addObject:object];
}
@end
