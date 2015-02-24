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
@interface CourseViewController ()

@end

@implementation CourseViewController

#pragma mark View
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.course.sections.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SectionTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"section"];
    if (cell == nil) {
        cell = [[SectionTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"section"];
    }
    Section * section = (Section *)self.course.sections[indexPath.row];
    [cell.registeredLabel setText:[NSString stringWithFormat:@"%ld/%ld registered", (long)section.registered, (long)section.seats]];
    [cell.sectionLabel setText:[NSString stringWithFormat:@"Type: %@", section.type]];
    [cell.instructorLabel setText:[NSString stringWithFormat:@"Instructor: %@", section.instructor]];
    [cell.sessionLabel setText:[NSString stringWithFormat:@"Session: %@", section.sessionCode]];
    [cell.locationLabel setText:[NSString stringWithFormat:@"Location: %@", section.location]];
    [cell.dayLabel setText:[NSString stringWithFormat:@"Days: %@", section.day]];
    [cell.timeLabel setText:[NSString stringWithFormat:@"Time: %@ - %@", section.beginTime, section.endTime]];
    [cell.unitsLabel setText:[NSString stringWithFormat:@"%ld units", (long)section.unitCode]];
    cell.mapButton.layer.cornerRadius = 15.0;
    [cell.registeredLabel sizeToFit];
    [cell.sectionLabel sizeToFit];
    [cell.sessionLabel sizeToFit];
    [cell.locationLabel sizeToFit];
    [cell.dayLabel sizeToFit];
    [cell.timeLabel sizeToFit];
    [cell.unitsLabel sizeToFit];
    [cell.instructorLabel sizeToFit];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.selectedSection = self.course.sections[indexPath.row];
    [self performSegueWithIdentifier:@"goToSection" sender:self];
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

}
-(void)reloadSections{
    dispatch_queue_t loadingQueue = dispatch_queue_create("loadingQueue",NULL);
    dispatch_async(loadingQueue, ^{
        [self.course downloadData];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
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
    else{// if([segue.identifier isEqualToString:@"filter"]){
        
    }
}
@end
