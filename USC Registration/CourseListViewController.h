//
//  CourseListViewController.h
//  USC Registration
//
//  Created by Vincent Ho on 2/20/15.
//  Copyright (c) 2015 HoLi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Department.h"
#import "AppDelegate.h"
#import "Course.h"
#import "FilterCourse.h"
@interface CourseListViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) FilterCourse * filter;
@property (nonatomic, strong) Department * department;
@property (nonatomic, strong) Course * course;
@property (nonatomic, strong) AppDelegate * appDelegate;
@property (nonatomic, strong) UIRefreshControl * refreshControl;
@property (nonatomic, strong) NSArray * arrayOfNavigationBarButtons;
@end
