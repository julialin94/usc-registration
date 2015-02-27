//
//  JLSchoolDepartmentViewController.m
//  USC Registration
//
//  Created by Vincent Ho on 2/23/15.
//  Copyright (c) 2015 HoLi. All rights reserved.
//

#import "JLSchoolDepartmentViewController.h"
#import "CourseListViewController.h"
#import "JLSchoolDepartmentTableViewCell.h"
#import "USColor.h"

@interface JLSchoolDepartmentViewController ()

@end

@implementation JLSchoolDepartmentViewController

#pragma mark Calendar
-(void)showCalendar{
    if(!self.appDelegate.calendar){
        self.appDelegate.calendar = [[Calendar alloc] init];
    }
    [self.appDelegate.calendar showCalendar];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *calendarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"calendar"] style:UIBarButtonItemStylePlain target:self action:@selector(showCalendar)];
    [self.navigationItem setRightBarButtonItem:calendarButton];
    self.appDelegate = [UIApplication sharedApplication].delegate;
    self.title = self.school.schoolCode;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.school.departments.count;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.selectedDepartment = [self.school.departments objectAtIndex:indexPath.row];
    [self loadForSegue];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    JLSchoolDepartmentTableViewCell * cell;
    cell = [tableView dequeueReusableCellWithIdentifier:@"department"];
    if (cell == nil) {
        cell = [[JLSchoolDepartmentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"department"];
    }
    NSString * department = ((Department*)self.school.departments[indexPath.row]).departmentDescription;
    NSString * departmentCode = ((Department*)self.school.departments[indexPath.row]).departmentCode;
    [cell.iconLabel setText:departmentCode];
    [cell.departmentLabel setText:department];
    [cell.iconLabel setTextColor:[UIColor blackColor]];
    [cell.departmentLabel setTextColor:[USColor JLCardinalColor]];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
        CourseListViewController * vc = [segue destinationViewController];
        vc.department = self.selectedDepartment;

}
 -(void)loadForSegue{
     if(!self.selectedDepartment.downloaded){
         self.appDelegate.progressHUD.labelText = @"Please wait.";
         self.appDelegate.progressHUD.detailsLabelText = [NSString stringWithFormat:@"Loading %@.", self.selectedDepartment.departmentCode];
         self.appDelegate.progressHUD.mode = MBProgressHUDModeIndeterminate;
         [self.navigationController.view addSubview:self.appDelegate.progressHUD];
         [self.appDelegate.progressHUD show:YES];
         dispatch_queue_t loadingQueue = dispatch_queue_create("loadingQueue",NULL);
         dispatch_async(loadingQueue, ^{
             [self.selectedDepartment downloadData];
             dispatch_async(dispatch_get_main_queue(), ^{
                 [self.appDelegate.progressHUD hide:YES];
                 [self.appDelegate.progressHUD removeFromSuperview];
                 [self performSegueWithIdentifier:@"goToCourses" sender:self];
             });
         });
     }
     else{
         [self performSegueWithIdentifier:@"goToCourses" sender:self];
     }
 }

@end
