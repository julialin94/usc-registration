//
//  CourseListViewController.m
//  USC Registration
//
//  Created by Vincent Ho on 2/20/15.
//  Copyright (c) 2015 HoLi. All rights reserved.
//

#import "CourseListViewController.h"
#import "CourseViewController.h"
#import "VHCourseTableViewCell.h"
@interface CourseListViewController ()

@end

@implementation CourseListViewController
#pragma mark Segue
-(void)loadForSegue{
    if(!self.course.downloaded){
        self.appDelegate.progressHUD.labelText = @"Please wait.";
        self.appDelegate.progressHUD.detailsLabelText = [NSString stringWithFormat:@"Loading %@.", self.course.sisCourseID];
        self.appDelegate.progressHUD.mode = MBProgressHUDModeIndeterminate;
        [self.navigationController.view addSubview:self.appDelegate.progressHUD];
        [self.appDelegate.progressHUD show:YES];
        dispatch_queue_t loadingQueue = dispatch_queue_create("loadingQueue",NULL);
        dispatch_async(loadingQueue, ^{
            [self.course downloadData];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.appDelegate.progressHUD hide:YES];
                [self.appDelegate.progressHUD removeFromSuperview];
                [self performSegueWithIdentifier:@"showSections" sender:self];
            });
        });
    }
    else{
        [self performSegueWithIdentifier:@"showSections" sender:self];
    }
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"showSections"]){
        CourseViewController * cvc = [segue destinationViewController];
        cvc.course = self.course;
    }
    else if([segue.identifier isEqualToString:@""]){
        
    }
}

#pragma mark UITableViewDelegate/DataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.department.courses.count;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.course = (Course*)[self.department.courses objectAtIndex:indexPath.row];
    [self loadForSegue];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    VHCourseTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"course"];
    if (cell == nil) {
        cell = [[VHCourseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"course"];
    }
    Course * course = (Course*)[self.department.courses objectAtIndex:indexPath.row];
    NSString * courseName = course.title;
    NSString * courseCodeLabel = course.sisCourseID;
    [cell.courseLabel setText:courseName];
    [cell.courseCodeLabel setText:courseCodeLabel];
    return cell;
}

#pragma mark Taps
-(void)filterPushed{
    [self performSegueWithIdentifier:@"filter" sender:self];
}
-(void)calendarPushed{
    [self performSegueWithIdentifier:@"showCalendar" sender:self];
}

#pragma mark View
- (void)viewDidLoad {
    [super viewDidLoad];
    self.appDelegate = [UIApplication sharedApplication].delegate;
    self.title = self.department.departmentCode;
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor purpleColor];
    self.refreshControl.tintColor = [UIColor orangeColor];
    [self.tableView addSubview:self.refreshControl];
    [self.refreshControl addTarget:self
                            action:@selector(reloadCourses)
                  forControlEvents:UIControlEventValueChanged];
    UIBarButtonItem *calendarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"calendar"] style:UIBarButtonItemStylePlain target:self action:@selector(calendarPushed)];
    UIBarButtonItem *filterButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"filter"] style:UIBarButtonItemStylePlain target:self action:@selector(filterPushed)];
    self.arrayOfNavigationBarButtons = [NSArray arrayWithObjects:filterButton, calendarButton, nil];
    [self.navigationItem setRightBarButtonItems:self.arrayOfNavigationBarButtons];
}
-(void)reloadCourses{
    dispatch_queue_t loadingQueue = dispatch_queue_create("loadingQueue",NULL);
    dispatch_async(loadingQueue, ^{
        [self.department downloadData];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            [self.refreshControl endRefreshing];
        });
    });
}
@end
