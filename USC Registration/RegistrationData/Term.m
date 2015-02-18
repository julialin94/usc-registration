//
//  Term.m
//  USC Registration
//
//  Created by hovincen on 2/17/15.
//  Copyright (c) 2015 HoLi. All rights reserved.
//

#import "Term.h"
#import "AppDelegate.h"
@implementation Term
-(id)initWithDictionary:(NSDictionary *)dict{
    self = [super init];
    self.schools = [[NSMutableArray alloc] init];
    self.commencementDate = [dict objectForKey:@"COMMENCEMENT_DATE"];
    self.termDescription = [dict objectForKey:@"DESCRIPTION"];
    self.earlyRegistrationStartDate = [dict objectForKey:@"EARLY_REG_START_DATE"];
    self.earlyRegistrationEndDate = [dict objectForKey:@"EARLY_REG_END_DATE"];
    self.normalRegistrationEndDate = [dict objectForKey:@"NORMAL_REG_END_DATE"];
    self.preregistrationEndDate = [dict objectForKey:@"PRE_REG_END_DATE"];
    self.preregistrationStartDate = [dict objectForKey:@"PRE_REG_START_DATE"];
    self.termCode = [dict objectForKey:@"TERM_CODE"];
    NSString * url = [NSString stringWithFormat:@"%@/schools", [self.appDelegate URL]];
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
    return self;
}
-(void)add:(id)object{
    [self.schools addObject:object];
}
@end
