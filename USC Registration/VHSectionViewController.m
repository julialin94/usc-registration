//
//  VHSectionViewController.m
//  USC Registration
//
//  Created by Vincent Ho on 2/24/15.
//  Copyright (c) 2015 HoLi. All rights reserved.
//

#import "VHSectionViewController.h"
#import "TermSchedule.h"
@interface VHSectionViewController ()

@end

@implementation VHSectionViewController

#pragma mark Calendar
-(void)showCalendar{
    if(!self.appDelegate.calendar){
        self.appDelegate.calendar = [[Calendar alloc] init];
    }
    [self.appDelegate.calendar showCalendar];
}
-(void)calendarPushed{
    [self showCalendar];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.appDelegate = [UIApplication sharedApplication].delegate;
    UIBarButtonItem *calendarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"calendar"] style:UIBarButtonItemStylePlain target:self action:@selector(calendarPushed)];
    [self.navigationItem setRightBarButtonItem:calendarButton];
    self.unitsLabel.text = [NSString stringWithFormat:@"%ld units", (long)self.section.unitCode];
    self.locationLabel.text = self.section.location;
    self.teacherLabel.text = self.section.instructor;
    self.seatsLabel.text = [NSString stringWithFormat:@"%ld/%ld registered", (long)self.section.registered, (long)self.section.seats];
    self.daysLabel.text = self.section.day;
    NSDateFormatter * df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"HH:mm";
    NSDate * start = [df dateFromString:self.section.beginTime];
    NSDate * end = [df dateFromString:self.section.endTime];
    df.dateFormat = @"hh:mm a";
    
    self.timesLabel.text = [NSString stringWithFormat:@"%@ to %@", [df stringFromDate:start], [df stringFromDate:end]];
    self.courseNameLabel.text = [NSString stringWithFormat:@"%@ %@", self.section.sisCourseID, self.section.type];;
    self.sectionNumberLabel.text = [NSString stringWithFormat:@"Section: %@", self.section.section];
    self.sessionLabel.text = [NSString stringWithFormat:@"Session: %@", self.section.sessionCode];
    
    
    
    
    
}
- (IBAction)addSectionAction:(id)sender {
    [self.appDelegate addSection:self.section];
}
@end
