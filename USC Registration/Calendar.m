//
//  Calendar.m
//  USC Registration
//
//  Created by Vincent Ho on 2/26/15.
//  Copyright (c) 2015 HoLi. All rights reserved.
//

#import "Calendar.h"
#import "AppDelegate.h"
#import "Section.h"
#import "ClassView.h"
@implementation Calendar

-(instancetype)init{
    self = [super init];
    
    return self;
}
-(void)showCalendar{
    for (UIView * subview in self.scrollView.subviews) {
        [subview removeFromSuperview];
    }
    CGRect frame = [UIApplication sharedApplication].keyWindow.frame;
    CGFloat width = frame.size.width - 30.0;
    [self.backgroundButton addTarget:self action:@selector(hideCalendar) forControlEvents:UIControlEventTouchUpInside];
    self.arrayOfDayPanels = [[NSMutableArray alloc] init];
    self.scrollView.clipsToBounds = YES;
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 30)];
    label.text = @"Schedule";
    label.textAlignment = NSTextAlignmentCenter;
    NSArray * days = [NSArray arrayWithObjects:@"M", @"T", @"W", @"TH", @"F", @"TBA", nil];
    [self.scrollView addSubview:label];
    CGFloat newWidth = width/7.0;
    CGFloat inset = 5.0;
    for(CGFloat a = 0; a<6; a++){
        UIView * dayPanel = [[UIView alloc] initWithFrame:CGRectMake(a*newWidth+newWidth - 5, newWidth+label.frame.size.height, newWidth, 450.0)];
        UILabel * dayLabel = [[UILabel alloc] initWithFrame:CGRectMake(newWidth*a+newWidth + inset - 5, inset+label.frame.size.height, newWidth-2*inset, newWidth-2*inset)];
        dayLabel.font = [UIFont systemFontOfSize:10.0];
        dayLabel.textAlignment = NSTextAlignmentCenter;
        dayLabel.backgroundColor = [UIColor blueColor];
        dayLabel.layer.cornerRadius = (newWidth-2*inset)/2.0;
        dayLabel.text = days[(int)a];
        dayLabel.textColor = [UIColor whiteColor];
        dayLabel.clipsToBounds = YES;
        [self.scrollView addSubview:dayLabel];
        [self.scrollView addSubview:dayPanel];
        dayPanel.backgroundColor = [UIColor clearColor];
        [self.arrayOfDayPanels addObject:dayPanel];
    }
    for (int a = 0; a<16; a++) {
        UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(newWidth-5, 30*a+newWidth+label.frame.size.height, 6*newWidth, 1)];
        lineView.backgroundColor = [UIColor grayColor];
        lineView.alpha = 0.7;
        [self.scrollView addSubview:lineView];
        UILabel * timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 30.0*a+newWidth+label.frame.size.height-10, newWidth-15, 20)];
        NSInteger hour = 7+a;
        NSMutableString * str = [NSMutableString stringWithFormat:@""];
        if(hour > 12)
            [str appendFormat:@"%ld", hour-12];
        else
            [str appendFormat:@"%ld", hour];
        if (hour >= 12)
            //PM
            [str appendString:@" PM"];
        else
            [str appendString:@" AM"];
        timeLabel.text = str;
        if(newWidth>50)
            timeLabel.font = [UIFont systemFontOfSize:10.0];
        else
            timeLabel.font = [UIFont systemFontOfSize:8.0];
        timeLabel.textAlignment = NSTextAlignmentRight;
        [self.scrollView addSubview:timeLabel];
    }
    for (int a = 0; a<7; a++) {
        UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(newWidth*(a+1)-5, newWidth+label.frame.size.height, 1, 450.0)];
        lineView.backgroundColor = [UIColor grayColor];
        lineView.alpha = 0.7;
        //        timeLabel.text =
        [self.scrollView addSubview:lineView];
    }
    AppDelegate * appDelegate = [UIApplication sharedApplication].delegate;
    CGFloat startY = newWidth+30+450;
    CGFloat endY = newWidth+30+450+30;
    if(![self.termSchedule contentEquals:appDelegate.termSchedule]){
        //has been updated, regenerate views
        for(int a = 0; a<appDelegate.termSchedule.dictionaryOfSections.allValues.count; a++){
            Section * s = appDelegate.termSchedule.dictionaryOfSections.allValues[a];
            NSLog(@"Calendar s: %@", s);
            ClassView * c = [[ClassView alloc] initWithSection:s andWidth:((UIView *)self.arrayOfDayPanels[0]).frame.size.width];
            if ([s.day containsString:@"M"]) {
                [self.arrayOfDayPanels[0] addSubview:[c copy]];
            }
            if ([s.day containsString:@"T"]) {
                [self.arrayOfDayPanels[1] addSubview:[c copy]];
            }
            if ([s.day containsString:@"W"]) {
                [self.arrayOfDayPanels[2] addSubview:[c copy]];
            }
            if ([s.day containsString:@"H"]) {
                [self.arrayOfDayPanels[3] addSubview:[c copy]];
            }
            if ([s.day containsString:@"F"]) {
                [self.arrayOfDayPanels[4] addSubview:[c copy]];
            }
            endY = startY + 30*a+30+30+30;
            UILabel * classLabel = [[UILabel alloc ] initWithFrame:CGRectMake(10, startY + 30*a+30, 6*newWidth, 30)];
            classLabel.text = [s description];
            classLabel.font = [UIFont systemFontOfSize:14.0];
            [self.scrollView addSubview:classLabel];
        }
        self.termSchedule = appDelegate.termSchedule;
    }
    self.scrollView.contentSize = CGSizeMake(width, endY);
    self.closeButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    self.closeButton.backgroundColor = [UIColor clearColor];
    [self.closeButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    self.closeButton.layer.cornerRadius = self.closeButton.frame.size.width/2;
    [self.closeButton setTitle:@"X" forState:UIControlStateNormal];
    self.closeButton.showsTouchWhenHighlighted = YES;
    [self.scrollView addSubview:self.closeButton];
    [self.closeButton addTarget:self action:@selector(hideCalendar) forControlEvents:UIControlEventTouchUpInside];
    [self show];
}
-(void)hideCalendar{
    [self hide];
}
@end
