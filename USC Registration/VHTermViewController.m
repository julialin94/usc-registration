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
#import "JLSchoolCollectionViewCell.h"
#import "School.h"
#import "JLSchoolDepartmentViewController.h"
#import "Calendar.h"
@interface VHTermViewController ()

@end

@implementation VHTermViewController
#pragma mark Calendar
-(void)showCalendar{
    if(!self.appDelegate.calendar){
        self.appDelegate.calendar = [[Calendar alloc] init];
    }
    [self.appDelegate.calendar showCalendar];
}

#pragma mark UICollectionViewDelegate/DataSource
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    self.selectedSchool = self.arrayOfSchools[indexPath.row];
    [self performSegueWithIdentifier:@"goToSchoolDepartment" sender:self];
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.arrayOfSchools.count;
}
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(JLSchoolCollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(8_0){
    cell.schoolIconView.alpha = 0.0;
    cell.schoolLabel.alpha = 0.0;
    cell.circleView.alpha = 0.0;
    [UIView animateWithDuration:0.2
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         cell.schoolIconView.alpha = 1.0;
                         cell.schoolLabel.alpha = 1.0;
                         cell.circleView.alpha = 1.0;
                     }
                     completion:nil];
    School * s = self.arrayOfSchools[indexPath.row];
    if(!s.shown){
        cell.circleView.transform = CGAffineTransformMakeScale(0.1, 0.1);
        cell.schoolIconView.transform = CGAffineTransformMakeScale(0.1, 0.1);
        cell.schoolLabel.transform = CGAffineTransformMakeScale(0.1, 0.1);
        s.shown = YES;
        [UIView animateWithDuration:0.15
                              delay:0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             cell.circleView.transform = CGAffineTransformMakeScale(1.1, 1.1);
                             cell.schoolIconView.transform = CGAffineTransformMakeScale(1.1, 1.1);
                             cell.schoolLabel.transform = CGAffineTransformMakeScale(1.1, 1.1);
                         }
                         completion:^(BOOL completed){
                             [UIView animateWithDuration:0.15
                                                   delay:0
                                                 options:UIViewAnimationOptionCurveEaseInOut
                                              animations:^{
                                                  cell.circleView.transform = CGAffineTransformMakeScale(1.0, 1.0);
                                                  cell.schoolIconView.transform = CGAffineTransformMakeScale(1.0, 1.0);
                                                  cell.schoolLabel.transform = CGAffineTransformMakeScale(1.0, 1.0);
                                              }
                                              completion:^(BOOL completed){
                                              }];
                         }];
    }

}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    JLSchoolCollectionViewCell * cell;
    cell = [collectionView dequeueReusableCellWithReuseIdentifier: @"school" forIndexPath:indexPath];
    cell.layer.shouldRasterize = YES;
    cell.layer.rasterizationScale = [UIScreen mainScreen].scale;
    NSString * school = ((School*)self.arrayOfSchools[indexPath.row]).schoolDescription;
    
    UIImage * image;
    if([school hasPrefix: @"Leventhal"]){
        image = [UIImage imageNamed:@"accounting.png"];
    }
    else if([school hasPrefix:@"Annenberg"]){
        image = [UIImage imageNamed:@"annenburg.png"];
    }
    else if([school hasPrefix:@"Architecture"]){
        image = [UIImage imageNamed:@"architecture.png"];
    }
    else if([school hasPrefix:@"Marshall"]){
        image = [UIImage imageNamed:@"business.png"];
    }
    else if([school hasPrefix:@"Cinematic"]){
        image = [UIImage imageNamed:@"cinema.png"];
    }
    else if([school hasPrefix:@"Kaufman"]){
        image = [UIImage imageNamed:@"dance.png"];
    }
    else if([school hasPrefix:@"Ostrow"]){
        image = [UIImage imageNamed:@"dentistry.png"];
    }
    else if([school hasPrefix:@"Physical"]){
        image = [UIImage imageNamed:@"physicaltherapy.png"];
    }
    else if([school hasPrefix:@"Rossier"]){
        image = [UIImage imageNamed:@"rossieredu.png"];
    }
    else if([school hasPrefix:@"Viterbi"]){
        image = [UIImage imageNamed:@"engineering.png"];
    }
    else if([school hasPrefix:@"Roski"]){
        image = [UIImage imageNamed:@"art.png"];
    }
    else if([school hasPrefix:@"General"]){
        image = [UIImage imageNamed:@"generaled.png"];
    }
    else if([school hasPrefix:@"Gerontology"]){
        image = [UIImage imageNamed:@"gerontology.png"];
    }
    else if([school hasPrefix:@"Graduate"]){
        image = [UIImage imageNamed:@"graduate.png"];
    }
    else if([school hasPrefix:@"Dornsife"]){
        image = [UIImage imageNamed:@"dornsife.png"];
    }
    else if([school hasPrefix:@"Law"]){
        image = [UIImage imageNamed:@"law.png"];
    }
    else if([school hasPrefix:@"Keck"]){
        image = [UIImage imageNamed:@"medicine.png"];
    }
    else if([school hasPrefix:@"Thornton"]){
        image = [UIImage imageNamed:@"music.png"];
    }
    else if([school hasPrefix:@"Occupational"]){
        image = [UIImage imageNamed:@"occupationaltherapy.png"];
    }
    else if([school hasPrefix:@"Pharmacy"]){
        image = [UIImage imageNamed:@"pharmacy.png"];
    }
    else if([school hasPrefix:@"Price"]){
        image = [UIImage imageNamed:@"policy.png"];
    }
    else if([school hasPrefix:@"Social"]){
        image = [UIImage imageNamed:@"socialwork.png"];
    }
    else if([school hasPrefix:@"Dramatic"]){
        image = [UIImage imageNamed:@"drama.png"];
    }
    else if([school hasPrefix:@"Iovine"]){
        image = [UIImage imageNamed:@"innovation.png"];
    }
    else{
        image = [UIImage imageNamed:@"general.png"];
    }
    cell.schoolIconView.image = image;
    cell.schoolIconView.contentMode = UIViewContentModeScaleAspectFit;
    [cell.schoolLabel setText:school];
    cell.schoolLabel.textAlignment = NSTextAlignmentCenter;
//    [cell.schoolLabel sizeToFit];
//    CGRect frame = CGRectMake(8, 116, cell.frame.size.width - 16.0, cell.schoolLabel.frame.size.height);
//    cell.schoolLabel.frame = frame;
    return cell;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGRect bounds = [UIScreen mainScreen].bounds;
    return CGSizeMake((bounds.size.width - 60.0)/2.0, 175);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(20, 20, 20, 20);
}

#pragma mark UITableViewDelegate/DataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger rtn = 0;
    switch (self.index) {
        case 0:
        case 1:
            rtn = self.arrayOfDepartments.count;
            break;
        case 2:
            rtn = self.arrayOfPrefixes.count;
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
            NSString * department = ((Department*)self.arrayOfDepartments[indexPath.row]).departmentDescription;
            NSString * departmentCode = ((Department*)self.arrayOfDepartments[indexPath.row]).departmentCode;
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
            NSString * department = ((Department*)self.arrayOfPrefixes[indexPath.row]).departmentDescription;
            NSString * departmentCode = ((Department*)self.arrayOfPrefixes[indexPath.row]).departmentCode;
            [cell.iconLabel setText:departmentCode];
            [cell.departmentLabel setText:department];
            [cell.iconLabel setTextColor:[USColor JLCardinalColor]];
            [cell.departmentLabel setTextColor:[UIColor blackColor]];
        }
            break;
    }
//    cell.backView.backgroundColor = [UIColor colorWithRed:231.0/225.0 green:234.0/255.0 blue:224.0/255.0 alpha:1.0];
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(VHDepartmentParentTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    Data * d = nil;
    switch (self.index) {
        case 0:
        case 1:{
            d = [self.arrayOfDepartments objectAtIndex:indexPath.row];
        }
            break;
        case 2:{
            d = [self.arrayOfPrefixes objectAtIndex:indexPath.row];
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
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.selectedDepartment = nil;
    switch (self.index) {
        case 0:{
            
        }
            break;
        case 1:{
            self.selectedDepartment = [self.arrayOfDepartments objectAtIndex:indexPath.row];
        }
            break;
        case 2:{
            self.selectedDepartment = [self.arrayOfPrefixes objectAtIndex:indexPath.row];
        }
            break;
    }
    [self loadForSegue];
    
}
#pragma mark Segue
-(void)loadForSegue{
    [self cancel];
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
    else if([segue.identifier isEqualToString:@"goToSchoolDepartment"]){
        [self cancel];
        JLSchoolDepartmentViewController * vc = [segue destinationViewController];
        vc.school = self.selectedSchool;
    }
}
#pragma mark UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self cancel];
    return YES;
}
-(void)textFieldDidChange :(UITextField *)theTextField{
    if (theTextField.text.length == 0) {
        self.arrayOfDepartments = self.term.departments;
        self.arrayOfSchools = self.term.schools;
        self.arrayOfPrefixes = self.term.prefixedDepartments;
        [self.tableView reloadData];
        [self.schoolCollectionView reloadData];
        return;
    }
    NSPredicate *predicateDepartments = [NSPredicate predicateWithFormat:@"(%K CONTAINS[c] %@) OR (%K CONTAINS[c] %@)", @"departmentDescription", theTextField.text, @"departmentCode", theTextField.text];
    self.arrayOfDepartments = [self.term.departments filteredArrayUsingPredicate:predicateDepartments];
    NSPredicate *predicateSchools = [NSPredicate predicateWithFormat:@"%K CONTAINS[c] %@", @"schoolDescription", theTextField.text];
    self.arrayOfSchools = [self.term.schools filteredArrayUsingPredicate:predicateSchools];
    NSPredicate *predicatePrefixes = [NSPredicate predicateWithFormat:@"(%K CONTAINS[c] %@) OR (%K CONTAINS[c] %@)", @"departmentDescription", theTextField.text, @"departmentCode", theTextField.text];
    self.arrayOfPrefixes = [self.term.prefixedDepartments filteredArrayUsingPredicate:predicatePrefixes];
    [self.tableView reloadData];
    [self.schoolCollectionView reloadData];
}
#pragma mark Taps
-(void)searchPushed{//show
    if (!self.searchView.hidden) {
        return;
    }
    self.redSearchView.hidden = NO;
    self.redSearchView.alpha = 0.0;
    self.searchView.hidden = NO;
    self.searchView.alpha = 0.0;
    [UIView animateWithDuration:0.3
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.redSearchView.alpha = 1.0;
                     }
                     completion:nil];
    [self.searchBar becomeFirstResponder];
    [UIView animateWithDuration:0.3
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.searchView.alpha = 0.8;
                         self.searchView.frame = CGRectOffset(self.searchView.frame, -self.searchView.frame.size.width-20, 0.0);
                     }
                     completion:^(BOOL completed){
                         [UIView animateWithDuration:0.1
                                               delay:0.0
                                             options:UIViewAnimationOptionCurveEaseInOut
                                          animations:^{
                                              self.searchView.alpha = 1.0;
                                              self.searchView.frame = CGRectOffset(self.searchView.frame, 20, 0.0);
                                          }
                                          completion:^(BOOL completed){
                                              [UIView animateWithDuration:0.05
                                                                    delay:0.0
                                                                  options:UIViewAnimationOptionCurveEaseInOut
                                                               animations:^{
                                                                   self.searchView.frame = CGRectOffset(self.searchView.frame, -10, 0.0);
                                                               }
                                                               completion:^(BOOL completed){
                                                                   [UIView animateWithDuration:0.025
                                                                                         delay:0.0
                                                                                       options:UIViewAnimationOptionCurveEaseInOut
                                                                                    animations:^{
                                                                                        self.searchView.frame = CGRectOffset(self.searchView.frame, 10, 0.0);
                                                                                    }
                                                                                    completion:nil];
                                                               }];
                                              }];
                         }];
}
-(void)cancel{
    if (self.searchView.hidden) {
        return;
    }
    [self.searchBar resignFirstResponder];
    [UIView animateWithDuration:0.4
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         self.searchView.alpha = 0.0;
                         self.searchView.frame = CGRectOffset(self.searchView.frame, self.searchView.frame.size.width, 0.0);
                     }
                     completion:^(BOOL completed){
                         self.searchView.hidden = YES;
                         [UIView animateWithDuration:0.3
                                               delay:0.0
                                             options:UIViewAnimationOptionCurveEaseInOut
                                          animations:^{
                                              self.redSearchView.alpha = 0.0;
                                          }
                                          completion:^(BOOL completed){
                                              self.redSearchView.hidden = YES;
                                          }];
                     }];
}
-(void)calendarPushed{
    [self showCalendar];
}
-(void)tapSchool{
    self.lastIndex = self.index;
    self.index = 0;
    [self.tableView setHidden:YES];
    [self.schoolCollectionView setHidden:NO];
    [self reloadView];
}
-(void)tapDepartment{
    self.lastIndex = self.index;
    self.index = 1;
    [self.tableView setHidden:NO];
    [self.schoolCollectionView setHidden:YES];
    [self reloadView];
    [self.tableView reloadData];
}
-(void)tapPrefixes{
    self.lastIndex = self.index;
    self.index = 2;
    [self.tableView setHidden:NO];
    [self.schoolCollectionView setHidden:YES];
    [self reloadView];
    [self.tableView reloadData];
}
#pragma mark Swipes
- (void)rightSwipeHandle:(UISwipeGestureRecognizer*)gestureRecognizer
{
    if(self.index>0){
        self.lastIndex = self.index;
        self.index--;
        [self reloadView];
        if(self.index!=0){
            [self.tableView setHidden:NO];
            [self.schoolCollectionView setHidden:YES];
            [self.tableView reloadData];
        }
        else{
            [self.tableView setHidden:YES];
            [self.schoolCollectionView setHidden:NO];
        }
    }
}

- (void)leftSwipeHandle:(UISwipeGestureRecognizer*)gestureRecognizer
{
    if(self.index<2){
        self.lastIndex = self.index;
        self.index++;
        [self reloadView];
        if(self.index!=0){
            [self.tableView setHidden:NO];
            [self.schoolCollectionView setHidden:YES];
            [self.tableView reloadData];
        }
        else{
            [self.tableView setHidden:YES];
            [self.schoolCollectionView setHidden:NO];
        }
    }
}

#pragma mark Views
- (void)viewDidLoad {
    [super viewDidLoad];
    self.modalPresentationStyle = UIModalPresentationCurrentContext;
    self.appDelegate = [UIApplication sharedApplication].delegate;
    self.term = self.appDelegate.termObject;
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
    self.schoolCollectionView.hidden = NO;
    self.tableView.hidden = YES;
    self.index = 0;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.schoolCollectionView setBackgroundColor:[USColor clearColor]];
    [self.tableView setBackgroundColor:[USColor clearColor]];
    [self.view setBackgroundColor:[USColor JLLightGrayColor]];
    [self.menuView setBackgroundColor:[USColor JLLightGrayColor]];
    
    
    
    
    UIBarButtonItem *calendarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"calendar"] style:UIBarButtonItemStylePlain target:self action:@selector(calendarPushed)];
    UIBarButtonItem *searchButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(searchPushed)];
    self.arrayOfNavigationBarButtons = [NSArray arrayWithObjects:searchButton, calendarButton, nil];
    [self.navigationItem setRightBarButtonItems:self.arrayOfNavigationBarButtons];
    
    
    self.arrayOfDepartments = self.term.departments;
    self.arrayOfSchools = self.term.schools;
    self.arrayOfPrefixes = self.term.prefixedDepartments;
    
}
-(void)viewWillAppear:(BOOL)animated{}
-(void)viewDidAppear:(BOOL)animated{
    CGRect frame = self.schoolLabel.frame;
    if (!self.searchView) {
        CGRect windowFrame = [UIApplication sharedApplication].keyWindow.frame;
        self.searchView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, windowFrame.size.width, 44)];
        self.searchView.hidden = YES;
        self.searchView.backgroundColor = [USColor clearColor];
        self.redSearchView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, windowFrame.size.width, 64)];
        self.redSearchView.hidden = YES;
        self.redSearchView.backgroundColor = [USColor JLCardinalColor];
        [[UIApplication sharedApplication].keyWindow addSubview:self.redSearchView];
        [[UIApplication sharedApplication].keyWindow addSubview:self.searchView];
        self.cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(windowFrame.size.width-100, 0, 100, 44)];
        self.cancelButton.backgroundColor = [UIColor clearColor];
        self.searchBar.frame = CGRectMake(10, 7, windowFrame.size.width-110, 30);
        [self.searchView addSubview:self.searchBar];
        [self.cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
        [self.cancelButton addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
        [self.searchView addSubview:self.cancelButton];
        self.searchView.frame = CGRectOffset(self.searchView.frame, self.searchView.frame.size.width, 0.0);
        self.searchBar.delegate = (id)self;
        [self.searchBar addTarget:self
                      action:@selector(textFieldDidChange:)
            forControlEvents:UIControlEventEditingChanged];
    }
    if(!self.lineView){
        self.lineView = [[UIView alloc] initWithFrame:CGRectMake(frame.origin.x, frame.origin.y+frame.size.height+1, frame.size.width, 6)];
        self.lineView.layer.cornerRadius = 2.0;
        self.lineView.backgroundColor = [USColor JLCardinalColor];
        [self.menuView addSubview:self.lineView];
        [self.menuView bringSubviewToFront:self.lineView];
//        self.menuView.alpha = 0.1;
        self.index = 0;
    }
    if(!self.trackView){
        self.trackView = [[UIView alloc] initWithFrame:CGRectMake(10.0, frame.origin.y+frame.size.height+3, self.menuView.frame.size.width-20.0, 2)];
        self.trackView.backgroundColor = [USColor lightGrayColor];
        [self.menuView addSubview:self.trackView];
        [self.menuView bringSubviewToFront:self.lineView];
    }
}
-(void)reloadView{
    for (Data * d in self.arrayOfDepartments) {
        d.shown = NO;
    }
    for (Data * d in self.arrayOfPrefixes) {
        d.shown = NO;
    }
    for (Data * d in self.arrayOfSchools) {
        d.shown = NO;
    }
    [UIView animateWithDuration:0.2
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         CGRect frame = ((UILabel *)self.arrayOfLabels[self.index]).frame;
                         [self.lineView setFrame:CGRectMake(frame.origin.x, frame.origin.y+frame.size.height+1, frame.size.width, 6)];
                     }
                     completion:^(BOOL finished){
                         
                     }];
}

#pragma mark IBAction
- (IBAction)backAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
