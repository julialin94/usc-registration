//
//  RequestParentViewController.h
//  USC Registration
//
//  Created by Vincent Ho on 2/11/15.
//  Copyright (c) 2015 HoLi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RequestParentViewController : UIViewController<NSURLConnectionDelegate>

@property (nonatomic, strong) NSMutableData *responseData;

//-(void)getCoursesWithTerm:(NSString *)term andOptions:(NSString *)options andSender:(id)sender;
//-(void)getSectionsWithID:(NSString *)sectionID andSender:(id)sender;
//-(void)getTermsWithCode:(NSString *)code andSender:(id)sender;
//-(void)getSchoolWithName:(NSString *)name andSender:(id)sender;
//-(void)getSessionsWithID:(NSString *)sessionID andSender:(id)sender;
@end
