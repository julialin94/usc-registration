//
//  TableViewRequestParentViewController.m
//  USC Registration
//
//  Created by Vincent Ho on 2/11/15.
//  Copyright (c) 2015 HoLi. All rights reserved.
//

#import "TableViewRequestParentViewController.h"

@interface TableViewRequestParentViewController ()

@end

static NSString * baseURL = @"http://petri.usc.edu/socAPI";
@implementation TableViewRequestParentViewController
-(void)viewDidLoad{
    [self.navigationController setNavigationBarHidden:NO];
}
#pragma mark NSURLConnection Delegate Methods
//-(void)getCoursesWithTerm:(NSString *)term andOptions:(NSString *)options andSender:(id)sender{
//    if(options == nil)
//        options = @"";
//    //get courses with term code
//    //empty string gives all, all gives section, other gives courses
//    NSString * url = [NSString stringWithFormat:@"%@/courses/%@/%@", baseURL, term, options];
//    [self performRequestWithURL:url andSender:sender];
//}
//-(void)getSectionsWithID:(NSString *)sectionID andSender:(id)sender{
//    //returns all sections with the id
//    if (sectionID == nil)
//        sectionID = @"";
//    NSString * url = [NSString stringWithFormat:@"%@/sections/%@", baseURL, sectionID];
//    [self performRequestWithURL:url andSender:sender];
//}
//-(void)getSchoolWithName:(NSString *)name andSender:(id)sender{
//    //get school with the department code provided, BUAD, etc
//    if(name == nil)
//        name = @"";
//    NSString * url = [NSString stringWithFormat:@"%@/schools/%@", baseURL, name];
//    [self performRequestWithURL:url andSender:sender];
//}
//-(void)getSessionsWithID:(NSString *)sessionID andSender:(id)sender{
//    //input session identifier, retursn session information: start/end date etc
//    if(sessionID == nil)
//        sessionID = @"";
//    NSString * url = [NSString stringWithFormat:@"%@/Sessions/%@", baseURL, sessionID];
//    [self performRequestWithURL:url andSender:sender];
//}
@end
