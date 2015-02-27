//
//  TermSchedule.m
//  USC Registration
//
//  Created by Vincent Ho on 2/24/15.
//  Copyright (c) 2015 HoLi. All rights reserved.
//

#import "TermSchedule.h"

@implementation TermSchedule
-(instancetype)init{
    self = [super init];
    self.dictionaryOfSections = [[NSMutableDictionary alloc] init];
    return self;
}
-(BOOL)contentEquals:(TermSchedule *)object{
    if(![self.termCode isEqualToString:object.termCode] )
        return NO;
    else if(!self.dictionaryOfSections.count != object.dictionaryOfSections.count)
        return NO;
    for (int a = 0; a<self.dictionaryOfSections.allKeys.count; a++) {
        NSString * key1 = self.dictionaryOfSections.allKeys[a];
        NSString * key2 = object.dictionaryOfSections.allKeys[a];
        if(![key1 isEqualToString:key2])
            return NO;
    }
    return YES;
}
@end
