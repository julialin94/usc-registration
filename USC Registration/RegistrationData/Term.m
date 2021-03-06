//
//  Term.m
//  USC Registration
//
//  Created by hovincen on 2/17/15.
//  Copyright (c) 2015 HoLi. All rights reserved.
//

#import "Term.h"
#import "AppDelegate.h"
#import "Department.h"
@implementation Term
-(id)initWithDictionary:(NSDictionary *)dict{
    self = [super init];
    self.schools = [[NSMutableArray alloc] init];
    self.departments = [[NSMutableArray alloc] init];
    self.commencementDate = [dict objectForKey:@"COMMENCEMENT_DATE"];
    self.termDescription = [dict objectForKey:@"DESCRIPTION"];
    self.earlyRegistrationStartDate = [dict objectForKey:@"EARLY_REG_START_DATE"];
    self.earlyRegistrationEndDate = [dict objectForKey:@"EARLY_REG_END_DATE"];
    self.normalRegistrationEndDate = [dict objectForKey:@"NORMAL_REG_END_DATE"];
    self.preregistrationEndDate = [dict objectForKey:@"PRE_REG_END_DATE"];
    self.preregistrationStartDate = [dict objectForKey:@"PRE_REG_START_DATE"];
    self.termCode = [dict objectForKey:@"TERM_CODE"];
    NSString * url = [NSString stringWithFormat:@"%@/Schools", [self.appDelegate URL]];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSURLResponse *response;
    NSData * data = [NSURLConnection sendSynchronousRequest:request
                                          returningResponse:&response
                                                      error:nil];
    NSError * error;
    dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    CGFloat count = 0;
    CGFloat max = ((NSArray *)dict).count;
    for (NSDictionary * school in dict) {
        School * s = [[School alloc] initWithDictionary:school];
        [self add:s];
        count++;
        dispatch_async(dispatch_get_main_queue(), ^{
            self.appDelegate.progressHUD.progress = count/max;
        });
    }
    
    NSSortDescriptor *sortDescriptor;
//    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"schoolDescription"
//                                                 ascending:YES];
    NSArray *sortDescriptors;// = [NSArray arrayWithObject:sortDescriptor];
//    self.schools = [[self.schools sortedArrayUsingDescriptors:sortDescriptors] mutableCopy];
    for (School * s in self.schools) {
//        NSLog(@"%@", s.schoolDescription);
        for (Department * d in s.departments) {
//            NSLog(@"\t%@", d.departmentDescription);
            [self.departments addObject:d];
        }
    }
    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"departmentDescription"
                                                 ascending:YES];
    sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    self.departments = [[self.departments sortedArrayUsingDescriptors:sortDescriptors] mutableCopy];
    
    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"departmentCode"
                                                 ascending:YES];
    sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    self.prefixedDepartments = [[self.departments sortedArrayUsingDescriptors:sortDescriptors] mutableCopy];
    return self;
}
-(void)add:(id)object{
    [self.schools addObject:object];
}
@end
