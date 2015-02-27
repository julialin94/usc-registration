//
//  CourseViewController.m
//  USC Registration
//
//  Created by Vincent Ho on 2/22/15.
//  Copyright (c) 2015 HoLi. All rights reserved.
//

#import "CourseViewController.h"
#import "SectionTableViewCell.h"
#import "Section.h"
#import "VHSectionViewController.h"
#import "FilterSection.h"
@interface CourseViewController ()

@end

@implementation CourseViewController
#pragma mark Delegate
-(void)filtered:(NSArray *)selections{
    NSMutableArray * days = [selections[0] mutableCopy];
    NSMutableArray * seats = [selections[3] mutableCopy];
    BOOL all0 = YES;
    for (int a = 0; a<days.count; a++) {
        if([days[a] boolValue])
            all0 = NO;
    }
    if (all0) {
        for (int a = 0; a<days.count; a++) {
            [days replaceObjectAtIndex:a withObject:@1];
        }
    }
    all0 = YES;
    for (int a = 0; a<seats.count; a++) {
        if([seats[a] boolValue])
            all0 = NO;
    }
    if (all0) {
        for (int a = 0; a<seats.count; a++) {
            [seats replaceObjectAtIndex:a withObject:@1];
        }
    }
//    self.arrayOfSections = [self.course.sections mutableCopy];
//    for (int a = self.arrayOfSections.count-1; a>=0; a--) {
//        Course * c = self.arrayOfSections[a];
//        BOOL matchesUnits = NO;
//        for (int b = 0; b<units.count; b++) {
//            NSNumber * sel = units[b];
//            BOOL selectedUnits = [sel boolValue];
//            int unit = b+1;
//            if((c.minUnits <= unit) && (c.minUnits >= unit) && selectedUnits){
//                matchesUnits = YES;
//            }
//        }
//        if(matchesUnits){
//            BOOL matchesLevelFlag = NO;
//            for (int b = 0; b<level.count; b++) {
//                BOOL matchesLevel = [level[b] boolValue];
//                if (matchesLevel) {
//                    //level = b
//                    if ([c.sisCourseID rangeOfString:@"-"].location != NSNotFound) {
//                        int index = [c.sisCourseID rangeOfString:@"-"].location;
//                        char ch = [c.sisCourseID characterAtIndex:index+1];
//                        NSLog(@"%d vs %d", ch, (b+48));
//                        if (ch == (b+48)) {
//                            matchesLevelFlag = YES;
//                        }
//                    }
//                }
//            }
//            if(!matchesLevelFlag){
//                [self.arrayOfCourses removeObjectAtIndex:a];
//            }
//        }
//        else{
//            [self.arrayOfCourses removeObjectAtIndex:a];
//        }
//        
//    }
    [self reloadTableView];
}
-(void)reloadTableView{
    [self.noResultsLabel removeFromSuperview];
    if (self.arrayOfSections.count == 0) {
        [self.view addSubview:self.noResultsLabel];
    }
    [self.tableView reloadData];
}
#pragma mark View
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrayOfSections.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SectionTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"section"];
    if (cell == nil) {
        cell = [[SectionTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"section"];
    }
    Section * section = (Section *)self.arrayOfSections[indexPath.row];
    [cell.registeredLabel setText:[NSString stringWithFormat:@"%ld/%ld registered", (long)section.registered, (long)section.seats]];
    [cell.sectionLabel setText:[NSString stringWithFormat:@"Type: %@", section.type]];
    [cell.instructorLabel setText:[NSString stringWithFormat:@"Instructor: %@", section.instructor]];
    [cell.sessionLabel setText:[NSString stringWithFormat:@"Session: %@", section.sessionCode]];
    [cell.locationLabel setText:[NSString stringWithFormat:@"Location: %@", section.location]];
    [cell.dayLabel setText:[NSString stringWithFormat:@"Days: %@", section.day]];
    
    NSDateFormatter * df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"HH:mm";
    NSDate * start = [df dateFromString:section.beginTime];
    NSDate * end = [df dateFromString:section.endTime];
    df.dateFormat = @"hh:mm a";
    NSString * startDate = [df stringFromDate:start];
    NSString * endDate = [df stringFromDate:end];
    
    
    [cell.timeLabel setText:[NSString stringWithFormat:@"Time: %@ - %@", startDate, endDate]];
    [cell.unitsLabel setText:[NSString stringWithFormat:@"%ld units", (long)section.unitCode]];
    cell.mapButton.layer.cornerRadius = 15.0;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.selectedSection = self.arrayOfSections[indexPath.row];
    [self performSegueWithIdentifier:@"goToSection" sender:self];
}


#pragma mark Calendar
-(void)showCalendar{
    if(!self.appDelegate.calendar){
        self.appDelegate.calendar = [[Calendar alloc] init];
    }
    [self.appDelegate.calendar showCalendar];
}
#pragma mark Taps
-(void)filterPushed{
    if(!self.filter)
        self.filter = [[FilterSection alloc] init];
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
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.appDelegate = [UIApplication sharedApplication].delegate;
    self.title = self.course.sisCourseID;
    [self.courseDescriptionLabel setText:self.course.courseDescription];
    [self.courseNameLabel setText:self.course.title];
    [self.courseNameLabel sizeToFit];
    [self.courseDescriptionLabel sizeToFit];
    self.tableView.estimatedRowHeight = 44.0;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor clearColor];
    self.refreshControl.tintColor = [UIColor orangeColor];
    [self.tableView addSubview:self.refreshControl];
    [self.refreshControl addTarget:self
                            action:@selector(reloadSections)
                  forControlEvents:UIControlEventValueChanged];
    UIBarButtonItem *calendarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"calendar"] style:UIBarButtonItemStylePlain target:self action:@selector(calendarPushed)];
    UIBarButtonItem *filterButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"filter"] style:UIBarButtonItemStylePlain target:self action:@selector(filterPushed)];
    self.arrayOfNavigationBarButtons = [NSArray arrayWithObjects:filterButton, calendarButton, nil];
    [self.navigationItem setRightBarButtonItems:self.arrayOfNavigationBarButtons];
    self.arrayOfSections = self.course.sections;

}
-(void)reloadSections{
    dispatch_queue_t loadingQueue = dispatch_queue_create("loadingQueue",NULL);
    dispatch_async(loadingQueue, ^{
        [self.course downloadData];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self reloadTableView];
            [self.refreshControl endRefreshing];
        });
    });
}

#pragma mark Segue
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"goToSection"]){
        VHSectionViewController * vc = segue.destinationViewController;
        vc.section = self.selectedSection;
    }
}
@end
