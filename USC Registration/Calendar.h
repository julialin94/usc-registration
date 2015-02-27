//
//  Calendar.h
//  USC Registration
//
//  Created by Vincent Ho on 2/26/15.
//  Copyright (c) 2015 HoLi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TermSchedule.h"
@interface Calendar : UIView
@property (nonatomic, strong) TermSchedule * termSchedule;
@property (nonatomic, strong) UIScrollView * scrollView;
@property (nonatomic, strong) UIButton * backgroundButton;
//@property (nonatomic, strong) UIView * monday;
//@property (nonatomic, strong) UIView * tuesday;
//@property (nonatomic, strong) UIView * wednesday;
//@property (nonatomic, strong) UIView * thursday;
//@property (nonatomic, strong) UIView * friday;
//@property (nonatomic, strong) UIView * tba;
@property (nonatomic, strong) NSMutableArray * arrayOfDayPanels;
-(void)showCalendar;
-(void)hideCalendar;
@end
