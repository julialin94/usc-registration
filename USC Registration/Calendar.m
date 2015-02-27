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
    CGRect frame = [UIApplication sharedApplication].keyWindow.frame;
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor clearColor];
    CGFloat width = frame.size.width - 30.0;
    CGFloat height = frame.size.height - 45.0;
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(15, -height, width, height)];
    self.backgroundButton = [[UIButton alloc] initWithFrame:frame];
    self.backgroundButton.backgroundColor = [UIColor blackColor];
    self.backgroundButton.alpha = 0.0;
    [self.backgroundButton addTarget:self action:@selector(hideCalendar) forControlEvents:UIControlEventTouchUpInside];
    self.arrayOfDayPanels = [[NSMutableArray alloc] init];
    self.scrollView.backgroundColor = [UIColor whiteColor];
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 30)];
    label.text = @"Schedule";
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.scrollView];
    [self.scrollView addSubview:label];
    UIButton * closeButton = [[UIButton alloc] initWithFrame:CGRectMake(-15, -15, 30, 30)];
    closeButton.backgroundColor = [UIColor blueColor];
    closeButton.layer.cornerRadius = closeButton.frame.size.width/2;
    [closeButton setTitle:@"X" forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(hideCalendar) forControlEvents:UIControlEventTouchUpInside];
    closeButton.showsTouchWhenHighlighted = YES;
    [self.scrollView addSubview:closeButton];
    self.scrollView.clipsToBounds = NO;
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
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [[UIApplication sharedApplication].keyWindow bringSubviewToFront:self];
    [self addSubview:self.backgroundButton];
    [self sendSubviewToBack:self.backgroundButton];
    [UIView animateWithDuration:0.2
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.backgroundButton.alpha = 0.7;
                         self.scrollView.frame = CGRectMake(15, 30, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
                     }
                     completion:^(BOOL finished){
                         
                     }];
    AppDelegate * appDelegate = [UIApplication sharedApplication].delegate;
    if(![self.termSchedule contentEquals:appDelegate.termSchedule]){
        //has been updated, regenerate views
        
        
        
        
        self.termSchedule = appDelegate.termSchedule;
    }
    
}
-(void)hideCalendar{
    [UIView animateWithDuration:0.2
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.backgroundButton.alpha = 0.0;
                         self.scrollView.frame = CGRectMake(15, -self.scrollView.frame.size.height, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
                     }
                     completion:^(BOOL finished){
                         [self.backgroundButton removeFromSuperview];
                         [self removeFromSuperview];
                     }];
}
@end
