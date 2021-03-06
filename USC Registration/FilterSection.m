//
//  FilterSection.m
//  USC Registration
//
//  Created by Vincent Ho on 2/26/15.
//  Copyright (c) 2015 HoLi. All rights reserved.
//

#import "FilterSection.h"
#import "FilterTableViewCell.h"
#import "USColor.h"

@implementation FilterSection
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) return 5;
    if (section == 1) return 8;
    if (section == 2) return 8;
    if (section == 3) return 2;
    else return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //static NSString * cellIdentifier = @"cell";
    FilterTableViewCell * cell;
    cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"FilterTableViewCell" owner:self options:nil];
        cell = (FilterTableViewCell *)[nib objectAtIndex:0];
    }
    NSInteger section = [indexPath section];
    switch (section) {
        case 0:
            cell.filterLabel.text = [self.daysArray objectAtIndex:[indexPath row]];
            break;
        case 1:
            cell.filterLabel.text = [self.timesAfterArray objectAtIndex:[indexPath row]];
            break;
        case 2:
            cell.filterLabel.text = [self.timesBeforeArray objectAtIndex:[indexPath row]];
            break;
        case 3:
            cell.filterLabel.text = [self.availableArray objectAtIndex:[indexPath row]];
            break;
            
        default:
            break;
    }
    NSNumber * num = ((NSArray *)self.optionsArray[indexPath.section])[indexPath.row];
    BOOL selected = [num integerValue];
    if (selected) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    
    return cell;
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 90;
    }
    else return 30;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSNumber * num = ((NSArray *)self.optionsArray[indexPath.section])[indexPath.row];
    BOOL selected = [num integerValue];
    FilterTableViewCell * cell = (FilterTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
    
    if (indexPath.section != 0) {
        if (selected) {
            cell.accessoryType = UITableViewCellAccessoryNone;
            [(NSMutableArray *)self.optionsArray[indexPath.section] replaceObjectAtIndex:indexPath.row withObject:@(0)];
        }
        else{
            NSInteger count = ((NSArray *)self.optionsArray[indexPath.section]).count;
            for (int a = 0; a<count; a++) {
                [self.optionsArray[indexPath.section] replaceObjectAtIndex:a withObject:@0];
            }
            [self.optionsArray[indexPath.section] replaceObjectAtIndex:indexPath.row withObject:@1];
        }
    }
    else{
        if (selected) {
            cell.accessoryType = UITableViewCellAccessoryNone;
            [(NSMutableArray *)self.optionsArray[indexPath.section] replaceObjectAtIndex:indexPath.row withObject:@(0)];
        }
        else{
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            [(NSMutableArray *)self.optionsArray[indexPath.section] replaceObjectAtIndex:indexPath.row withObject:@(1)];
        }
    }
    [self.sectionFilterTableView reloadData];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section != 0) {
        UIView *sectionHeaderView = [[UIView alloc] initWithFrame:
                                     CGRectMake(0, 0, tableView.frame.size.width, 30)];
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, tableView.frame.size.width, 30)];
        switch (section) {
            case 1:
                label.text = @"Starting After";
                break;
            case 2:
                label.text = @"Ending Before";
                break;
            case 3:
                label.text = @"Has Available Seats";
                break;
        }
        
        [sectionHeaderView addSubview:label];
        return sectionHeaderView;
    }
    
    UIView *sectionHeaderView = [[UIView alloc] initWithFrame:
                                 CGRectMake(0, 0, tableView.frame.size.width, 60.0)];
    sectionHeaderView.backgroundColor = [UIColor clearColor];
    UIView * background = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 50)];
    background.backgroundColor = [UIColor colorWithRed:153.0/255.0 green:0 blue:0 alpha:1.0];
    [sectionHeaderView addSubview:background];
    UIButton * doneButton = [[UIButton alloc] initWithFrame:CGRectMake(tableView.frame.size.width-40, 10, 30, 30)];
    UIButton * resetButton = [[UIButton alloc] initWithFrame:CGRectMake(tableView.frame.size.width-75, 11, 25, 25)];
    
    resetButton.showsTouchWhenHighlighted = YES;
    doneButton.contentMode = UIViewContentModeScaleAspectFit;
    resetButton.contentMode = UIViewContentModeScaleAspectFit;
    self.closeButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    self.closeButton.titleLabel.font = [UIFont fontWithName:@"Roboto" size:25.0];
    [sectionHeaderView addSubview:self.closeButton];
    [sectionHeaderView addSubview:doneButton];
    [sectionHeaderView addSubview:resetButton];
    
    self.closeButton.backgroundColor = [UIColor clearColor];
    [self.closeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.closeButton setTitle:@"X" forState:UIControlStateNormal];
    self.closeButton.showsTouchWhenHighlighted = YES;
    [self.closeButton addTarget:self action:@selector(hideFilter) forControlEvents:UIControlEventTouchUpInside];
    
    
    doneButton.backgroundColor = [UIColor clearColor];
    doneButton.contentMode = UIViewContentModeScaleAspectFit;
    resetButton.contentMode = UIViewContentModeScaleAspectFit;
    [doneButton setImage:[UIImage imageNamed:@"whiteFilter"] forState:UIControlStateNormal];
    [doneButton addTarget:self action:@selector(filterDone) forControlEvents:UIControlEventTouchUpInside];
    resetButton.backgroundColor = [UIColor clearColor];
    [resetButton setImage:[UIImage imageNamed:@"undo"] forState:UIControlStateNormal];
    [resetButton addTarget:self action:@selector(reset) forControlEvents:UIControlEventTouchUpInside];
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(10, 40, tableView.frame.size.width, 50)];
    label.text = @"Exclude Days";
    [sectionHeaderView addSubview:label];
    doneButton.showsTouchWhenHighlighted = YES;
    resetButton.showsTouchWhenHighlighted = YES;
    return sectionHeaderView;
}
-(instancetype)init{
    self = [super init];
    CGFloat width = [UIApplication sharedApplication].keyWindow.frame.size.width;
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 30)];
    label.text = @"Filter";
    label.textAlignment = NSTextAlignmentCenter;
    [self.scrollView addSubview:label];
    [self.backgroundButton addTarget:self action:@selector(hideFilter) forControlEvents:UIControlEventTouchUpInside];
    [self.closeButton addTarget:self action:@selector(hideFilter) forControlEvents:UIControlEventTouchUpInside];
    self.scrollView.clipsToBounds = NO;
    
    CGRect frame = CGRectMake(15, 30, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
    self.sectionFilterTableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
    self.sectionFilterTableView.dataSource = (id) self;
    self.sectionFilterTableView.delegate = (id) self;
    //    self.sectionFilterTableView.allowsMultipleSelection = YES;
    
    self.daysArray = [[NSMutableArray alloc] initWithObjects: @"Monday", @"Tuesday", @"Wednesday", @"Thursday", @"Friday", nil];
    self.timesAfterArray = [[NSMutableArray alloc] initWithObjects: @"10 am",@"11 am",@"12 pm",@"1 pm",@"2 pm",@"3 pm",@"4 pm",@"5 pm", @"Afternoon", nil];
    self.timesBeforeArray = [[NSMutableArray alloc] initWithObjects: @"12 pm",@"1 pm",@"2 pm",@"3 pm",@"4 pm",@"5 pm",@"6 pm",@"7 pm", nil];
    self.availableArray = [[NSMutableArray alloc] initWithObjects: @"Yes", @"No", nil];
    self.optionsArray = [[NSMutableArray alloc] init];
    NSMutableArray * array1 = [[NSMutableArray alloc] init];
    NSMutableArray * array2 = [[NSMutableArray alloc] init];
    NSMutableArray * array3 = [[NSMutableArray alloc] init];
    NSMutableArray * array4 = [[NSMutableArray alloc] init];
    for (NSString * str in self.daysArray) {
        [array1 addObject:@0];
    }
    for (NSString * str in self.timesAfterArray) {
        [array2 addObject:@0];
    }
    for (NSString * str in self.timesAfterArray) {
        [array3 addObject:@0];
    }
    for (NSString * str in self.timesAfterArray) {
        [array4 addObject:@0];
    }
    [self.optionsArray addObject: array1];
    [self.optionsArray addObject: array2];
    [self.optionsArray addObject: array3];
    [self.optionsArray addObject: array4];
    
    [self addSubview:self.sectionFilterTableView];

    self.backgroundButton.enabled = NO;
    return self;
}
-(void)showFilter{
    [self bringSubviewToFront:self.backgroundButton];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [[UIApplication sharedApplication].keyWindow bringSubviewToFront:self];
    [self addSubview:self.backgroundButton];
    [self sendSubviewToBack:self.backgroundButton];
    [UIView animateWithDuration:0.2
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.backgroundButton.alpha = 0.7;
                     }
                     completion:^(BOOL finished){
                         
                     }];
}
-(void)hideFilter{
    [UIView animateWithDuration:0.2
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.backgroundButton.alpha = 0.0;
                     }
                     completion:^(BOOL finished){
                         [self.backgroundButton removeFromSuperview];
                         [self removeFromSuperview];
                     }];
}

-(void)reset{
    self.optionsArray = [[NSMutableArray alloc] init];
    NSMutableArray * array1 = [[NSMutableArray alloc] init];
    NSMutableArray * array2 = [[NSMutableArray alloc] init];
    NSMutableArray * array3 = [[NSMutableArray alloc] init];
    NSMutableArray * array4 = [[NSMutableArray alloc] init];
    for (NSString * str in self.daysArray) {
        [array1 addObject:@0];
    }
    for (NSString * str in self.timesAfterArray) {
        [array2 addObject:@0];
    }
    for (NSString * str in self.timesAfterArray) {
        [array3 addObject:@0];
    }
    for (NSString * str in self.timesAfterArray) {
        [array4 addObject:@0];
    }
    [self.optionsArray addObject: array1];
    [self.optionsArray addObject: array2];
    [self.optionsArray addObject: array3];
    [self.optionsArray addObject: array4];
    [self.sectionFilterTableView reloadData];
}
-(void)filterDone{
    [[self delegate] filtered:self.optionsArray];
    [self hideFilter];
}
@end
