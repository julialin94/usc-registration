//
//  Department.m
//  USC Registration
//
//  Created by hovincen on 2/17/15.
//  Copyright (c) 2015 HoLi. All rights reserved.
//

#import "Department.h"
#import "Course.h"
@implementation Department
-(id)initWithDictionary:(NSDictionary *)dict{
    self = [super init];
    self.courses = [[NSMutableArray alloc] init];
    self.departmentCode = [dict objectForKey:@"SOC_DEPARTMENT_CODE"];
    self.departmentDescription = [dict objectForKey:@"SOC_DEPARTMENT_DESCRIPTION"];
    NSLog(@"\t->%@", self.departmentDescription);
    self.schoolCode = [dict objectForKey:@"SOC_SCHOOL_CODE"];
    
    /*
     Don't download courses and their information
     */
    
//    NSString * url = [NSString stringWithFormat:@"%@/courses/%@/%@", [self.appDelegate URL], self.appDelegate.term, self.departmentCode];
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
//    NSURLResponse *response;
//    NSData * data = [NSURLConnection sendSynchronousRequest:request
//                                          returningResponse:&response
//                                                      error:nil];
//    NSError * error;
//    dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
//    for (NSDictionary * course in dict) {
//        Course * c = [[Course alloc] initWithDictionary:course];
//        [self add:c];
//    }
    return self;
}
-(void)add:(id)object{
    [self.courses addObject:object];
}
@end
