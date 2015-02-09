//
//  Department.h
//  USC Registration
//
//  Created by hovincen on 2/8/15.
//  Copyright (c) 2015 HoLi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Department : NSManagedObject

@property (nonatomic, retain) NSString * departmentCode;
@property (nonatomic, retain) NSString * departmentDescription;
@property (nonatomic, retain) NSString * schoolCode;

@end
