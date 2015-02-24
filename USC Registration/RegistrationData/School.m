//
//  School.m
//  USC Registration
//
//  Created by hovincen on 2/17/15.
//  Copyright (c) 2015 HoLi. All rights reserved.
//

#import "School.h"
#import "AppDelegate.h"
#import "Department.h"
@implementation School
-(id)initWithDictionary:(NSDictionary *)dict{
    self = [super init];
    self.departments = [[NSMutableArray alloc] init];
    self.schoolCode = [dict objectForKey:@"SOC_SCHOOL_CODE"];
    self.schoolDescription = [dict objectForKey:@"SOC_SCHOOL_DESCRIPTION"];
//    NSLog(@"->%@", self.schoolDescription);
    NSString * url = [NSString stringWithFormat:@"%@/schools/%@", [self.appDelegate URL], self.schoolCode];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSURLResponse *response;
    NSData * data = [NSURLConnection sendSynchronousRequest:request
                                          returningResponse:&response
                                                      error:nil];
    NSError * error;
    dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    for (NSDictionary * department in [((NSArray*)dict)[0] objectForKey:@"SOC_DEPARTMENT_CODE"]) {
        Department * d = [[Department alloc] initWithDictionary:department];
        [self add:d];
    }
    NSSortDescriptor *sortDescriptor;
    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"departmentDescription"
                                                 ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    self.departments = [[self.departments sortedArrayUsingDescriptors:sortDescriptors] mutableCopy];
    return self;
}
-(void)add:(id)object{
    [self.departments addObject:object];
}
@end
