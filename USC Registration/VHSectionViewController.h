//
//  VHSectionViewController.h
//  USC Registration
//
//  Created by Vincent Ho on 2/24/15.
//  Copyright (c) 2015 HoLi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Section.h"
#import "AppDelegate.h"
@interface VHSectionViewController : UIViewController
- (IBAction)addSectionAction:(id)sender;
@property (nonatomic, strong) Section * section;
@property (nonatomic, strong) AppDelegate * appDelegate;
@property (weak, nonatomic) UIButton *addButton;
@property (weak, nonatomic) IBOutlet UILabel *unitsLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *teacherLabel;
@property (weak, nonatomic) IBOutlet UILabel *seatsLabel;
@property (weak, nonatomic) IBOutlet UILabel *daysLabel;
@property (weak, nonatomic) IBOutlet UILabel *timesLabel;

@property (weak, nonatomic) IBOutlet UILabel *courseNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *sectionTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *sectionNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *sessionLabel;



@end
