//
//  CourseViewController.h
//  USC Registration
//
//  Created by Vincent Ho on 2/22/15.
//  Copyright (c) 2015 HoLi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Course.h"
#import "Section.h"
#import "FilterSection.h"
#import "AppDelegate.h"
@interface CourseViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, FilterSectionDelegate>
@property (nonatomic, strong) Course * course;
@property (nonatomic, strong) FilterSection * filter;
@property (weak, nonatomic) IBOutlet UIView *detailsView;
@property (weak, nonatomic) IBOutlet UILabel *courseNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *courseDescriptionLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UIRefreshControl * refreshControl;
@property (nonatomic, strong) NSArray * arrayOfNavigationBarButtons;
@property (nonatomic, strong) Section * selectedSection;
@property (nonatomic, strong) NSMutableArray * arrayOfSections;
@property (nonatomic, strong) UILabel * noResultsLabel;
@property (nonatomic, strong) AppDelegate * appDelegate;

@end
