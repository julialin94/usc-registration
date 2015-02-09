//
//  Course.h
//  USC Registration
//
//  Created by hovincen on 2/8/15.
//  Copyright (c) 2015 HoLi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Course : NSManagedObject

@property (nonatomic, retain) NSNumber * courseID;
@property (nonatomic, retain) NSString * sisCourseID;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSNumber * minUnits;
@property (nonatomic, retain) NSNumber * maxUnits;
@property (nonatomic, retain) NSString * courseDescription;
@property (nonatomic, retain) NSNumber * diversity;
@property (nonatomic, retain) NSString * effectiveTermCode;
@property (nonatomic, retain) id sections;

@end
