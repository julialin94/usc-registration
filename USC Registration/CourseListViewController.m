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
#import "USColor.h"
#import "FilterCourse.h"
@interface CourseListViewController ()

@end

@implementation CourseListViewController
#pragma mark Calendar
-(void)showCalendar{
    if(!self.appDelegate.calendar){
        self.appDelegate.calendar = [[Calendar alloc] init];
    }
    [self.appDelegate.calendar showCalendar];
}
#pragma mark Delegate
-(void)filtered:(NSArray *)selections{
    NSMutableArray * units = [selections[0] mutableCopy];
    NSMutableArray * level = [selections[1] mutableCopy];
    BOOL all0 = YES;
    for (int a = 0; a<units.count; a++) {
        if([units[a] boolValue])
            all0 = NO;
    }
    if (all0) {
        for (int a = 0; a<units.count; a++) {
            [units replaceObjectAtIndex:a withObject:@1];
        }
    }
    all0 = YES;
    for (int a = 0; a<level.count; a++) {
        if([level[a] boolValue])
            all0 = NO;
    }
    if (all0) {
        for (int a = 0; a<level.count; a++) {
            [level replaceObjectAtIndex:a withObject:@1];
        }
    }
    self.arrayOfCourses = [self.department.courses mutableCopy];
    for (int a = (int)self.arrayOfCourses.count-1; a>=0; a--) {
        Course * c = self.arrayOfCourses[a];
//        NSLog(@"%lu", (unsigned long)[c.sisCourseID rangeOfString:@"-"].location);
        NSLog(@"course: %@", c);
        BOOL matchesUnits = NO;
        for (int b = 0; b<units.count; b++) {
            NSNumber * sel = units[b];
            BOOL selectedUnits = [sel boolValue];
            int unit = b+1;
            if((c.minUnits <= unit) && (c.minUnits >= unit) && selectedUnits){
                matchesUnits = YES;
            }
        }
        if(matchesUnits){
            BOOL matchesLevelFlag = NO;
            for (int b = 0; b<level.count; b++) {
                BOOL matchesLevel = [level[b] boolValue];
                if (matchesLevel) {
                    //level = b
                    if ([c.sisCourseID rangeOfString:@"-"].location != NSNotFound) {
                        int index = (int)[c.sisCourseID rangeOfString:@"-"].location;
                        char ch = [c.sisCourseID characterAtIndex:index+1];
                        NSLog(@"%d vs %d", ch, (b+48));
                        if (ch == (b+48)) {
                            matchesLevelFlag = YES;
                        }
                    }
                }
            }
            if(!matchesLevelFlag){
                [self.arrayOfCourses removeObjectAtIndex:a];
            }
        }
        else{
            [self.arrayOfCourses removeObjectAtIndex:a];
        }
        
    }
    [self reloadTableView];
}
-(void)reloadTableView{
    [self.noResultsLabel removeFromSuperview];
    if (self.arrayOfCourses.count == 0) {
        [self.view addSubview:self.noResultsLabel];
    }
    [self.tableView reloadData];
}
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
}

#pragma mark UITableViewDelegate/DataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrayOfCourses.count;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.course = (Course*)[self.arrayOfCourses objectAtIndex:indexPath.row];
    [self loadForSegue];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    VHCourseTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"course"];
    if (cell == nil) {
        cell = [[VHCourseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"course"];
    }
    Course * course = (Course*)[self.arrayOfCourses objectAtIndex:indexPath.row];
    NSString * courseName = course.title;
    NSString * courseCodeLabel = course.sisCourseID;
    [cell.courseLabel setText:courseName];
    [cell.courseCodeLabel setText:courseCodeLabel];
    return cell;
}

#pragma mark Taps
-(void)filterPushed{
    if(!self.filter)
        self.filter = [[FilterCourse alloc] init];
    self.filter.delegate = (id)self;
    [self.filter showFilter];
}
-(void)calendarPushed{
    [self showCalendar];
}

#pragma mark View
-(void)viewDidAppear:(BOOL)animated{
    [self.noResultsLabel removeFromSuperview];
    if (!self.noResultsLabel) {
        self.noResultsLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.tableView.frame.origin.x, 64+self.tableView.frame.origin.y, self.tableView.frame.size.width, 30)];
        self.noResultsLabel.textAlignment = NSTextAlignmentCenter;
        self.noResultsLabel.text = @"No results found :(";
        if(self.arrayOfCourses.count == 0)
            [self.view addSubview:self.noResultsLabel];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.appDelegate = [UIApplication sharedApplication].delegate;
    self.title = self.department.departmentCode;
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor clearColor];
    self.refreshControl.tintColor = [UIColor orangeColor];
    [self.tableView addSubview:self.refreshControl];
    [self.refreshControl addTarget:self
                            action:@selector(reloadCourses)
                  forControlEvents:UIControlEventValueChanged];
    UIBarButtonItem *calendarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"calendar"] style:UIBarButtonItemStylePlain target:self action:@selector(calendarPushed)];
    UIBarButtonItem *filterButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"filter"] style:UIBarButtonItemStylePlain target:self action:@selector(filterPushed)];
    self.arrayOfNavigationBarButtons = [NSArray arrayWithObjects:filterButton, calendarButton, nil];
    [self.navigationItem setRightBarButtonItems:self.arrayOfNavigationBarButtons];
    
    [self.tableView setBackgroundColor:[USColor clearColor]];
    [self.view setBackgroundColor:[USColor JLLightGrayColor]];
    self.arrayOfCourses = [self.department.courses mutableCopy];
}
-(void)reloadCourses{
    dispatch_queue_t loadingQueue = dispatch_queue_create("loadingQueue",NULL);
    dispatch_async(loadingQueue, ^{
        [self.department downloadData];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self reloadTableView];
            [self.refreshControl endRefreshing];
        });
    });
}
@end
