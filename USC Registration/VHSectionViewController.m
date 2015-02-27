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
-(void)calendarPushed{
    [self performSegueWithIdentifier:@"showCalendar" sender:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.appDelegate = [UIApplication sharedApplication].delegate;
    UIBarButtonItem *calendarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"calendar"] style:UIBarButtonItemStylePlain target:self action:@selector(calendarPushed)];
    [self.navigationItem setRightBarButtonItem:calendarButton];
}
- (IBAction)addSectionAction:(id)sender {
    [self.appDelegate addSection:self.section];
}
@end
