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
#import "USColor.h"
#import "Term.h"
@implementation Calendar
-(void)selectedClassView:(id)c{
    for (NSArray * arr in self.arrayOfClassViews) {
        for (ClassView * cv in arr) {
            if (c != cv) {
                [cv deselect];
            }
        }
    }
    
}
-(BOOL)overlapView1:(UIView *)view1 andView2:(UIView *)view2{
    if (CGRectContainsRect([view1 frame], [view2 frame])) {
        NSLog(@"Overlap!");
        return YES;
    }
    return NO;
}
-(instancetype)init{
    self = [super init];
    self.scrollView.backgroundColor = [USColor JLLightGrayColor];
    return self;
}
-(void)showCalendar{
    AppDelegate * appDelegate = [UIApplication sharedApplication].delegate;
    for (UIView * subview in self.scrollView.subviews) {
        [subview removeFromSuperview];
    }
    CGRect frame = [UIApplication sharedApplication].keyWindow.frame;
    CGFloat width = frame.size.width - 30.0;
    [self.backgroundButton addTarget:self action:@selector(hideCalendar) forControlEvents:UIControlEventTouchUpInside];
    self.arrayOfDayPanels = [[NSMutableArray alloc] init];
    self.arrayOfClassViews = [[NSMutableArray alloc] init];
    [self.arrayOfClassViews addObject:[[NSMutableArray alloc] init]];
    [self.arrayOfClassViews addObject:[[NSMutableArray alloc] init]];
    [self.arrayOfClassViews addObject:[[NSMutableArray alloc] init]];
    [self.arrayOfClassViews addObject:[[NSMutableArray alloc] init]];
    [self.arrayOfClassViews addObject:[[NSMutableArray alloc] init]];
    [self.arrayOfClassViews addObject:[[NSMutableArray alloc] init]];
    self.scrollView.clipsToBounds = YES;
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 30)];
    NSString * str = appDelegate.termObject.termDescription;
    NSString * char1 = [str substringWithRange:NSMakeRange(0, 1)];
    str = [[str substringFromIndex:1] lowercaseString];
    NSInteger unitCount = 0;
    
    label.textAlignment = NSTextAlignmentCenter;
    NSArray * days = [NSArray arrayWithObjects:@"M", @"T", @"W", @"TH", @"F", @"TBA", nil];
    [self.scrollView addSubview:label];
    CGFloat newWidth = width/7.0;
    CGFloat inset = 5.0;
    for(CGFloat a = 0; a<6; a++){
        UIView * dayPanel = [[UIView alloc] initWithFrame:CGRectMake(a*newWidth+newWidth - 5, newWidth+label.frame.size.height, newWidth, 450.0)];
        UILabel * dayLabel = [[UILabel alloc] initWithFrame:CGRectMake(newWidth*a+newWidth + inset - 5, inset+label.frame.size.height, newWidth-2*inset, newWidth-2*inset)];
        dayPanel.backgroundColor = [UIColor clearColor];
        dayLabel.font = [UIFont systemFontOfSize:10.0];
        dayLabel.textAlignment = NSTextAlignmentCenter;
        dayLabel.backgroundColor = [USColor JLDarkBlueColor];
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
        lineView.alpha = 0.5;
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
    CGFloat startY = newWidth+30+450;
    CGFloat endY = newWidth+30+450+30;
    NSInteger numInTBA = 0;
    if(![self.termSchedule contentEquals:appDelegate.termSchedule]){
        //has been updated, regenerate views
        for(int a = 0; a<appDelegate.termSchedule.dictionaryOfSections.allValues.count; a++){
            Section * s = appDelegate.termSchedule.dictionaryOfSections.allValues[a];
            unitCount += s.unitCode;
            endY = startY + 30*a+30+30+30;
            UILabel * classLabel = [[UILabel alloc ] initWithFrame:CGRectMake(10, startY + 30*a+30, width-20, 30)];
            classLabel.text = [NSString stringWithFormat:@" %d. %@", (a+1), [s description]];
            classLabel.font = [UIFont systemFontOfSize:14.0];
            classLabel.layer.cornerRadius = 5.0f;
            classLabel.numberOfLines = 0;
            classLabel.clipsToBounds = YES;
            [self.scrollView addSubview:classLabel];
            ClassView * c = [[ClassView alloc] initWithSection:s andWidth:((UIView *)self.arrayOfDayPanels[0]).frame.size.width andCount:(a+1) andLabel:classLabel andNumberInTBA:numInTBA];
            if ([s.day containsString:@"M"]) {
                ClassView * cv = [c copy];
                cv.delegate = self;
                [self.arrayOfClassViews[0] addObject:cv];
                [self.arrayOfDayPanels[0] addSubview:cv];
            }
            if ([s.day containsString:@"T"]) {
                ClassView * cv = [c copy];
                cv.delegate = self;
                [self.arrayOfClassViews[1] addObject:cv];
                [self.arrayOfDayPanels[1] addSubview:cv];
            }
            if ([s.day containsString:@"W"]) {
                ClassView * cv = [c copy];
                cv.delegate = self;
                [self.arrayOfClassViews[2] addObject:cv];
                [self.arrayOfDayPanels[2] addSubview:cv];
            }
            if ([s.day containsString:@"H"]) {
                ClassView * cv = [c copy];
                cv.delegate = self;
                [self.arrayOfClassViews[3] addObject:cv];
                [self.arrayOfDayPanels[3] addSubview:cv];
            }
            if ([s.day containsString:@"F"]) {
                ClassView * cv = [c copy];
                cv.delegate = self;
                [self.arrayOfClassViews[4] addObject:cv];
                [self.arrayOfDayPanels[4] addSubview:cv];
            }
            if ([s.day containsString:@"tba"]) {
                numInTBA++;
                ClassView * cv = [c copy];
                cv.delegate = self;
                [self.arrayOfClassViews[5] addObject:cv];
                [self.arrayOfDayPanels[5] addSubview:cv];
            }
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
    for (int a = 0; a<self.arrayOfClassViews.count; a++) {
        for (int b = 0; b<((NSArray*)self.arrayOfClassViews[a]).count; b++) {
            for (int c = b+1; c<((NSArray*)self.arrayOfClassViews[a]).count; c++) {
                if ([self overlapView1:self.arrayOfClassViews[a][b] andView2:self.arrayOfClassViews[a][c]]) {
                    [(ClassView *)self.arrayOfClassViews[a][b] conflict];
                    [(ClassView *)self.arrayOfClassViews[a][c] conflict];
                }
            }
        }
    }
    
    label.text = [NSString stringWithFormat:@"%@%@ Schedule (%ld Units)", char1, str, (long)unitCount];
    
    [self show];
}
-(void)hideCalendar{
    [self hide];
}
@end
