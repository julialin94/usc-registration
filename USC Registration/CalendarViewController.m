//
//  CalendarViewController.m
//  USC Registration
//
//  Created by Vincent Ho on 2/24/15.
//  Copyright (c) 2015 HoLi. All rights reserved.
//

#import "CalendarViewController.h"
#import "Section.h"
@interface CalendarViewController ()

@end

@implementation CalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.appDelegate = [UIApplication sharedApplication].delegate;
    // Do any additional setup after loading the view.
}
-(void)viewDidAppear:(BOOL)animated{
    NSLog(@"Registered Classes: ");
    for(NSString * str in self.appDelegate.termSchedule.dictionaryOfSections.allKeys){
        Section * s = [self.appDelegate.termSchedule.dictionaryOfSections objectForKey:str];
        NSLog(@"%@ from %@-%@ on %@", s.sisCourseID, s.beginTime, s.endTime, s.day);
    }
}

- (IBAction)dismissButtonAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
