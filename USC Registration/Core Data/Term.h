//
//  Term.h
//  USC Registration
//
//  Created by hovincen on 2/8/15.
//  Copyright (c) 2015 HoLi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Term : NSManagedObject

@property (nonatomic, retain) NSString * termCode;
@property (nonatomic, retain) NSDate * normalRegistrationEndDate;
@property (nonatomic, retain) NSDate * earlyRegistrationEndDate;
@property (nonatomic, retain) NSDate * earlyRegistrationStartDate;
@property (nonatomic, retain) NSDate * preregistrationEndDate;
@property (nonatomic, retain) NSDate * preregistrationStartDate;
@property (nonatomic, retain) NSString * termDescription;
@property (nonatomic, retain) NSDate * commencementDate;

@end
