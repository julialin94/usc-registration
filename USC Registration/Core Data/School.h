//
//  School.h
//  USC Registration
//
//  Created by hovincen on 2/8/15.
//  Copyright (c) 2015 HoLi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface School : NSManagedObject

@property (nonatomic, retain) NSString * schoolCode;
@property (nonatomic, retain) NSString * schoolDescription;
@property (nonatomic, retain) id departmentCodes;

@end
