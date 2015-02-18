//
//  Data.h
//  USC Registration
//
//  Created by hovincen on 2/17/15.
//  Copyright (c) 2015 HoLi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
@interface Data : NSObject
@property (nonatomic, strong) AppDelegate * appDelegate;
-(id)initWithDictionary:(NSDictionary *)dict;
-(void)add:(id)object;
@end
