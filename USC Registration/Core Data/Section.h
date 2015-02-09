//
//  Section.h
//  USC Registration
//
//  Created by hovincen on 2/8/15.
//  Copyright (c) 2015 HoLi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Section : NSManagedObject

@property (nonatomic, retain) NSString * termCode;
@property (nonatomic, retain) NSString * courseID;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * sisCourseID;
@property (nonatomic, retain) NSString * section;
@property (nonatomic, retain) NSString * session;
@property (nonatomic, retain) NSNumber * unitCode;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSString * beginTime;
@property (nonatomic, retain) NSString * endTime;
@property (nonatomic, retain) NSString * day;
@property (nonatomic, retain) NSNumber * registered;
@property (nonatomic, retain) NSNumber * seats;
@property (nonatomic, retain) NSString * instructor;
@property (nonatomic, retain) NSString * location;
@property (nonatomic, retain) NSDate * addDate;
@property (nonatomic, retain) NSDate * cancelDate;
@property (nonatomic, retain) NSString * publishFlag;
@property (nonatomic, retain) NSString * publishSectionFlag;

@end
