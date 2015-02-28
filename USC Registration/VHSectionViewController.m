//
//  VHSectionViewController.m
//  USC Registration
//
//  Created by Vincent Ho on 2/24/15.
//  Copyright (c) 2015 HoLi. All rights reserved.
//

#import "VHSectionViewController.h"
#import "TermSchedule.h"
#import "USColor.h"
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
    if ([self.section.day isEqualToString:@"tba"]) {
        self.daysLabel.text = @"TBA";
    }
    else{
        self.daysLabel.text = self.section.day;
    }
    if ([self.section.beginTime isEqualToString:@"TBA"]) {
        self.timesLabel.text = @"TBA";
    }
    else{
        NSDateFormatter * df = [[NSDateFormatter alloc] init];
        df.dateFormat = @"HH:mm";
        NSDate * start = [df dateFromString:self.section.beginTime];
        NSDate * end = [df dateFromString:self.section.endTime];
        df.dateFormat = @"hh:mm a";
        self.timesLabel.text = [NSString stringWithFormat:@"%@ to %@", [df stringFromDate:start], [df stringFromDate:end]];
    }
    if ([self.section.type isEqualToString:@"unknown"]) {
        self.courseNameLabel.text = self.section.sisCourseID;
    }
    else{
        self.courseNameLabel.text = [NSString stringWithFormat:@"%@ %@", self.section.sisCourseID, self.section.type];
    }
    self.sectionNumberLabel.text = [NSString stringWithFormat:@"Section: %@", self.section.section];
    self.sessionLabel.text = [NSString stringWithFormat:@"Session: %@", self.section.sessionCode];
    NSLog(@"object: %@", [self.appDelegate.savedSections objectForKey:self.section.section]);
    if ([self.appDelegate.savedSections objectForKey:self.section.section] == nil) {
        //leave the button the way it is
        [self.addButton setTitle:@"Add" forState:UIControlStateNormal];
        self.addButton.backgroundColor = [USColor JLDarkBlueColor];
    }
    else{
        [self.addButton setTitle:@"Remove" forState:UIControlStateNormal];
        self.addButton.backgroundColor = [USColor JLDarkRedColor];
    }
    
    
    
}
- (IBAction)addSectionAction:(id)sender {
    if ([self.addButton.titleLabel.text isEqualToString:@"Add"]) {
        [self.appDelegate addSection:self.section];
        [self.addButton setTitle:@"Remove" forState:UIControlStateNormal];
        self.addButton.backgroundColor = [USColor JLDarkRedColor];
    }
    else{
        [self.appDelegate removeSection:self.section];
        [self.addButton setTitle:@"Add" forState:UIControlStateNormal];
        self.addButton.backgroundColor = [USColor JLDarkBlueColor];
    }
}
@end
