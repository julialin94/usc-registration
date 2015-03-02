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
//    NSLog(@"\t->%@", self.departmentDescription);
    self.schoolCode = [dict objectForKey:@"SOC_SCHOOL_CODE"];
    
    self.courses = [[NSMutableArray alloc] init];
    /*
     Don't download courses and their information until later.
     */
    return self;
}
-(void) downloadData{
    NSString * url = [NSString stringWithFormat:@"%@/Courses/%@/%@", [self.appDelegate URL], self.appDelegate.term, self.departmentCode];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSURLResponse *response;
    NSData * data = [NSURLConnection sendSynchronousRequest:request
                                          returningResponse:&response
                                                      error:nil];
    NSLog(@"data: %@", data);
    if (data == nil) {
        UIAlertView * av = [[UIAlertView alloc] initWithTitle:@"Connection error!" message:@"Please check your internet connection." delegate:nil cancelButtonTitle:@"OK!" otherButtonTitles:nil];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [av show];
        });
        return;
    }
    NSError * error;
    NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    self.downloaded = YES;
    if(error){
        UIAlertView * av = [[UIAlertView alloc] initWithTitle:@"Connection error!" message:@"Please check your internet connection." delegate:nil cancelButtonTitle:@"OK!" otherButtonTitles:nil];
        [av show];
    }
    else{
        self.courses = [[NSMutableArray alloc] init];
        for (NSDictionary * course in dict) {
            Course * c = [[Course alloc] initWithDictionary:course];
            [self add:c];
        }
    }
}
-(void)add:(id)object{
    [self.courses addObject:object];
}
@end
