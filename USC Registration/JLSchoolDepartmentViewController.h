//
//  JLSchoolDepartmentViewController.h
//  USC Registration
//
//  Created by Vincent Ho on 2/23/15.
//  Copyright (c) 2015 HoLi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "School.h"
#import "Department.h"
#import "AppDelegate.h"


@interface JLSchoolDepartmentViewController : UITableViewController
@property (nonatomic, strong) AppDelegate * appDelegate;
@property (nonatomic, strong) School * school;
@property (strong, nonatomic) Department * selectedDepartment;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
