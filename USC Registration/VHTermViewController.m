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
@interface VHTermViewController ()

@end

@implementation VHTermViewController
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
    NSLog(@"return: %ld", (long)rtn);
    return rtn;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell;
    switch (self.index) {
        case 0:
//            cell = nil;
//            break;
        case 1:{
            VHDepartmentTableViewCell * tempCell = [tableView dequeueReusableCellWithIdentifier:@"department"];
            if (tempCell == nil) {
                tempCell = [[VHDepartmentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"department"];
            }
            NSString * department = ((Department*)self.term.departments[indexPath.row]).departmentDescription;
            NSString * departmentCode = ((Department*)self.term.departments[indexPath.row]).departmentCode;
            [tempCell.iconLabel setText:departmentCode];
            [tempCell.departmentLabel setText:department];
            cell = tempCell;
        }
            break;
        case 2:{
            VHPrefixTableViewCell * tempCell = [tableView dequeueReusableCellWithIdentifier:@"prefix"];
            if (tempCell == nil) {
                tempCell = [[VHPrefixTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"prefix"];
            }
            NSString * department = ((Department*)self.term.prefixedDepartments[indexPath.row]).departmentDescription;
            NSString * departmentCode = ((Department*)self.term.prefixedDepartments[indexPath.row]).departmentCode;
            [tempCell.prefixLabel setText:departmentCode];
            [tempCell.departmentLabel setText:department];
            cell = tempCell;
        }
            break;
    }
    return cell;
}
-(void)tapSchool{
    self.index = 0;
    [self reloadView];
    [self.tableView reloadData];
}
-(void)tapDepartment{
    self.index = 1;
    [self reloadView];
    [self.tableView reloadData];
}
-(void)tapPrefixes{
    self.index = 2;
    [self reloadView];
    [self.tableView reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
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
//    [self.menuView addGestureRecognizer:leftSwipe];
//    [self.menuView addGestureRecognizer:rightSwipe];
    self.arrayOfLabels = [[NSMutableArray alloc] initWithObjects:self.schoolLabel, self.departmentLabel, self.prefixLabel, nil];
}
-(void)viewDidAppear:(BOOL)animated{
    
    CGRect frame = self.schoolLabel.frame;
    self.lineView = [[UIView alloc] initWithFrame:CGRectMake(frame.origin.x, frame.origin.y+frame.size.height+2, frame.size.width, 3)];
    self.lineView.backgroundColor = [UIColor redColor];
    [self.menuView addSubview:self.lineView];
    [self.menuView bringSubviewToFront:self.lineView];
    self.index = 0;
}
-(void)reloadView{
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
        self.index--;
        [self reloadView];
        [self.tableView reloadData];
    }
}

- (void)leftSwipeHandle:(UISwipeGestureRecognizer*)gestureRecognizer
{
    if(self.index<2){
        self.index++;
        [self reloadView];
        [self.tableView reloadData];
    }
}
@end
