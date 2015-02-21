//
//  CourseListViewController.m
//  USC Registration
//
//  Created by Vincent Ho on 2/20/15.
//  Copyright (c) 2015 HoLi. All rights reserved.
//

#import "CourseListViewController.h"
#import "Course.h"
#import "VHCourseTableViewCell.h"
@interface CourseListViewController ()

@end

@implementation CourseListViewController
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.department.courses.count;
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
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.department.departmentCode;
}
-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO];
}
@end
