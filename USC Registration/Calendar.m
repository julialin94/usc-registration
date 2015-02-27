//
//  Calendar.m
//  USC Registration
//
//  Created by Vincent Ho on 2/26/15.
//  Copyright (c) 2015 HoLi. All rights reserved.
//

#import "Calendar.h"
#import "AppDelegate.h"
@implementation Calendar
-(instancetype)init{
    self = [super init];
    CGRect frame = [UIApplication sharedApplication].keyWindow.frame;
    CGFloat width = frame.size.width - 30.0;
    [self.backgroundButton addTarget:self action:@selector(hideCalendar) forControlEvents:UIControlEventTouchUpInside];
    [self.closeButton addTarget:self action:@selector(hideCalendar) forControlEvents:UIControlEventTouchUpInside];
    self.arrayOfDayPanels = [[NSMutableArray alloc] init];
    self.scrollView.clipsToBounds = NO;
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 30)];
    label.text = @"Schedule";
    label.textAlignment = NSTextAlignmentCenter;
    [self.scrollView addSubview:label];
    for(CGFloat a = 0; a<6; a++){
        NSLog(@"%f", a*width/6.0);
        UIView * dayPanel = [[UIView alloc] initWithFrame:CGRectMake(a*width/6.0, 30, width/6.0, 300.0)];
        [self.scrollView addSubview:dayPanel];
        dayPanel.backgroundColor = [UIColor grayColor];
        [self.arrayOfDayPanels addObject:dayPanel];
    }
    return self;
}
-(void)showCalendar{
    [self show];
    AppDelegate * appDelegate = [UIApplication sharedApplication].delegate;
    if(![self.termSchedule contentEquals:appDelegate.termSchedule]){
        //has been updated, regenerate views
        
        
        
        
        self.termSchedule = appDelegate.termSchedule;
    }
    
}
-(void)hideCalendar{
    [self hide];
}
@end
