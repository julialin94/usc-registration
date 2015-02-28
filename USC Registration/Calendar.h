//
//  Calendar.h
//  USC Registration
//
//  Created by Vincent Ho on 2/26/15.
//  Copyright (c) 2015 HoLi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TermSchedule.h"
#import "Popup.h"
#import "ClassView.h"
@interface Calendar : Popup <ClassViewDelegate>
@property (nonatomic, strong) TermSchedule * termSchedule;
@property (nonatomic, strong) NSMutableArray * arrayOfDayPanels;
@property (nonatomic, strong) NSMutableArray * arrayOfClassViews;
-(void)showCalendar;
-(void)hideCalendar;
@end
