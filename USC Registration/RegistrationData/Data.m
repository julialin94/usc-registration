//
//  Data.m
//  USC Registration
//
//  Created by hovincen on 2/17/15.
//  Copyright (c) 2015 HoLi. All rights reserved.
//

#import "Data.h"

@implementation Data
static NSString * baseURL = @"http://petri.usc.edu/socAPI";
-(instancetype)init{
    self = [super init];
    self.appDelegate = [[UIApplication sharedApplication] delegate];
    return self;
}
#pragma mark Abstract Methods
-(void)add:(id)object{
    
}
-(id)initWithDictionary:(NSDictionary *)dict{
    return [self init];
}
@end
