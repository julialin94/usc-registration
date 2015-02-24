//
//  CalendarViewController.h
//  USC Registration
//
//  Created by Vincent Ho on 2/24/15.
//  Copyright (c) 2015 HoLi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@interface CalendarViewController : UIViewController
- (IBAction)dismissButtonAction:(id)sender;
@property (nonatomic, strong) AppDelegate * appDelegate;
@end
