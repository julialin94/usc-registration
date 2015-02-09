//
//  Session.h
//  USC Registration
//
//  Created by hovincen on 2/8/15.
//  Copyright (c) 2015 HoLi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Session : NSManagedObject

@property (nonatomic, retain) NSNumber * sessionID;
@property (nonatomic, retain) NSString * termCode;
@property (nonatomic, retain) NSString * sessionCode;
@property (nonatomic, retain) NSDate * classBeginDate;
@property (nonatomic, retain) NSDate * lastAddDropDate;
@property (nonatomic, retain) NSDate * withdrawWWDate;
@property (nonatomic, retain) NSDate * finalExamBeginDate;
@property (nonatomic, retain) NSDate * finalExamEndDate;
@property (nonatomic, retain) NSDate * classEndDate;
@property (nonatomic, retain) NSDate * stopDate;

@end
