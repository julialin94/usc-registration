//
//  VHTermViewController.m
//  USC Registration
//
//  Created by Vincent Ho on 2/11/15.
//  Copyright (c) 2015 HoLi. All rights reserved.
//

#import "VHTermViewController.h"
#import "VHDepartmentTableViewCell.h"
#import "VHPrefixTableViewCell.h"
#import "Department.h"
#import "CourseListViewController.h"
#import "Data.h"
#import "USColor.h"
#import "VHDepartmentParentTableViewCell.h"
@interface VHTermViewController ()

@end

@implementation VHTermViewController
#pragma mark UITableViewDelegate/DataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger rtn = 0;
    switch (self.index) {
        case 0:
//            rtn = 0;
//            break;
        case 1:
            rtn = self.term.departments.count;
            break;
        case 2:
            rtn = self.term.prefixedDepartments.count;
            break;
    }
    return rtn;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    VHDepartmentParentTableViewCell * cell;
    switch (self.index) {
        case 0:
        case 1:{
            cell = [tableView dequeueReusableCellWithIdentifier:@"department"];
            if (cell == nil) {
                cell = [[VHDepartmentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"department"];
            }
            NSString * department = ((Department*)self.term.departments[indexPath.row]).departmentDescription;
            NSString * departmentCode = ((Department*)self.term.departments[indexPath.row]).departmentCode;
            [cell.iconLabel setText:departmentCode];
            [cell.departmentLabel setText:department];
            [cell.iconLabel setTextColor:[UIColor blackColor]];
            [cell.departmentLabel setTextColor:[USColor JLCardinalColor]];
        }
            break;
        case 2:{
            cell = [tableView dequeueReusableCellWithIdentifier:@"department"];
            if (cell == nil) {
                cell = [[VHPrefixTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"department"];
            }
            NSString * department = ((Department*)self.term.prefixedDepartments[indexPath.row]).departmentDescription;
            NSString * departmentCode = ((Department*)self.term.prefixedDepartments[indexPath.row]).departmentCode;
            [cell.iconLabel setText:departmentCode];
            [cell.departmentLabel setText:department];
            [cell.iconLabel setTextColor:[USColor JLCardinalColor]];
            [cell.departmentLabel setTextColor:[UIColor blackColor]];
        }
            break;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(VHDepartmentParentTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    Data * d = nil;
    switch (self.index) {
        case 0:
        case 1:{
            d = [self.term.departments objectAtIndex:indexPath.row];
        }
            break;
        case 2:{
            d = [self.term.prefixedDepartments objectAtIndex:indexPath.row];
        }
            break;
    }
    cell.iconLabel.alpha = 0.0;
    cell.departmentLabel.alpha = 0.0;
    [UIView animateWithDuration:0.2
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         cell.iconLabel.alpha = 1.0;
                         cell.departmentLabel.alpha = 1.0;
                     }
                     completion:nil];
    if(!d.shown){
        d.shown = YES;
        CGFloat multiplier = (self.lastIndex < self.index) ? 1.0 : -1.0;
        cell.transform = CGAffineTransformMakeTranslation(cell.frame.size.width*0.5*multiplier, 0);
        [UIView animateWithDuration:0.15 animations:^{
            cell.transform = CGAffineTransformIdentity;
        }];
        
        
        
        
        
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.selectedDepartment = nil;
    switch (self.index) {
        case 0:{
            
        }
            break;
        case 1:{
            self.selectedDepartment = [self.term.departments objectAtIndex:indexPath.row];
        }
            break;
        case 2:{
            self.selectedDepartment = [self.term.departments objectAtIndex:indexPath.row];
        }
            break;
    }
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
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"goToCourses"]){
        CourseListViewController * vc = [segue destinationViewController];
        vc.department = self.selectedDepartment;
    }
}
-(void)tapSchool{
    self.lastIndex = self.index;
    self.index = 0;
    [self reloadView];
    [self.tableView reloadData];
}
-(void)tapDepartment{
    self.lastIndex = self.index;
    self.index = 1;
    [self reloadView];
    [self.tableView reloadData];
}
-(void)tapPrefixes{
    self.lastIndex = self.index;
    self.index = 2;
    [self reloadView];
    [self.tableView reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.appDelegate = [UIApplication sharedApplication].delegate;
    self.term = self.appDelegate.termObject;
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem = backButton;
    [self.navigationController.navigationBar setBarTintColor:self.view.backgroundColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{
                                                                      NSForegroundColorAttributeName : [USColor JLGoldColor]}];
    [self.navigationController.navigationBar setTintColor:[USColor JLGoldColor]];
    [self.navigationController.navigationBar setTranslucent:YES];
    UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightSwipeHandle:)];
    rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    [rightSwipe setNumberOfTouchesRequired:1];
    UISwipeGestureRecognizer *leftSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftSwipeHandle:)];
    leftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
    [leftSwipe setNumberOfTouchesRequired:1];
    
    //add the your gestureRecognizer , where to detect the touch..
    [self.view addGestureRecognizer:leftSwipe];
    [self.view addGestureRecognizer:rightSwipe];
    [self setTitle:self.term.termDescription];
    self.schoolLabel.userInteractionEnabled = YES;
    self.departmentLabel.userInteractionEnabled = YES;
    self.prefixLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer * tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapSchool)];
    [self.schoolLabel addGestureRecognizer:tap1];
    UITapGestureRecognizer * tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDepartment)];
    [self.departmentLabel addGestureRecognizer:tap2];
    UITapGestureRecognizer * tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPrefixes)];
    [self.prefixLabel addGestureRecognizer:tap3];
    self.arrayOfLabels = [[NSMutableArray alloc] initWithObjects:self.schoolLabel, self.departmentLabel, self.prefixLabel, nil];
}
-(void)viewWillAppear:(BOOL)animated{
    [self.tableView setBackgroundColor:[USColor clearColor]];
    [self.view setBackgroundColor:[USColor JLLightGrayColor]];
    [self.menuView setBackgroundColor:[UIColor clearColor]];
}
-(void)viewDidAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO];
    CGRect frame = self.schoolLabel.frame;
    if(!self.lineView){
        self.lineView = [[UIView alloc] initWithFrame:CGRectMake(frame.origin.x, frame.origin.y+frame.size.height+2, frame.size.width, 3)];
        self.lineView.backgroundColor = [USColor JLCardinalColor];
        [self.menuView addSubview:self.lineView];
        [self.menuView bringSubviewToFront:self.lineView];
        self.index = 0;
    }
}
-(void)reloadView{
    for (Data * d in self.term.departments) {
        d.shown = NO;
    }
    for (Data * d in self.term.prefixedDepartments) {
        d.shown = NO;
    }
    [UIView animateWithDuration:0.2
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         CGRect frame = ((UILabel *)self.arrayOfLabels[self.index]).frame;
                         [self.lineView setFrame:CGRectMake(frame.origin.x, frame.origin.y+frame.size.height+2, frame.size.width, 3)];
                     }
                     completion:^(BOOL finished){
                         
                     }];
}
- (void)rightSwipeHandle:(UISwipeGestureRecognizer*)gestureRecognizer
{
    if(self.index>0){
        self.lastIndex = self.index;
        self.index--;
        [self reloadView];
        [self.tableView reloadData];
    }
}

- (void)leftSwipeHandle:(UISwipeGestureRecognizer*)gestureRecognizer
{
    if(self.index<2){
        self.lastIndex = self.index;
        self.index++;
        [self reloadView];
        [self.tableView reloadData];
    }
}
- (void)backAction{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
