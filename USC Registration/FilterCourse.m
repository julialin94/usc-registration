//
//  FilterCourse.m
//  USC Registration
//
//  Created by Vincent Ho on 2/26/15.
//  Copyright (c) 2015 HoLi. All rights reserved.
//

#import "FilterCourse.h"
#import "FilterTableViewCell.h"
#import "USColor.h"

@implementation FilterCourse
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) return 5;
    if (section == 1) return 9;
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
            //NSString * unit = (self.unitsArray[indexPath.row]);
            cell.filterLabel.text = [self.unitsArray objectAtIndex:[indexPath row]];
            break;
        
        case 1:
            cell.filterLabel.text = [self.levelsArray objectAtIndex:[indexPath row]];
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

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    NSString * title = nil;
    switch (section) {
        case 0:
            title = @"Units";
            break;
        case 1:
            title = @"Course Level";
            break;
        default:
            break;
    }
    return title;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSNumber * num = ((NSArray *)self.optionsArray[indexPath.section])[indexPath.row];
    BOOL selected = [num integerValue];
    FilterTableViewCell * cell = (FilterTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
    if (selected) {
        cell.accessoryType = UITableViewCellAccessoryNone;
        [(NSMutableArray *)self.optionsArray[indexPath.section] replaceObjectAtIndex:indexPath.row withObject:@(0)];
    }
    else{
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        [(NSMutableArray *)self.optionsArray[indexPath.section] replaceObjectAtIndex:indexPath.row withObject:@(1)];
    }
}

-(instancetype)init{
    self = [super init];
    self.scrollView.clipsToBounds = NO;
    CGFloat width = [UIApplication sharedApplication].keyWindow.frame.size.width;
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 30)];
    label.text = @"Filter";
    label.textAlignment = NSTextAlignmentCenter;
    [self.scrollView addSubview:label];
    [self.backgroundButton addTarget:self action:@selector(hideFilter) forControlEvents:UIControlEventTouchUpInside];
    [self.closeButton addTarget:self action:@selector(hideFilter) forControlEvents:UIControlEventTouchUpInside];
    self.scrollView.clipsToBounds = NO;
    CGRect frame = CGRectMake(15, 30, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
    self.courseFilterTableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
    self.courseFilterTableView.dataSource = (id) self;
    self.courseFilterTableView.delegate = (id) self;
//    self.courseFilterTableView.allowsMultipleSelection = YES;
    
    self.unitsArray = [[NSMutableArray alloc] initWithObjects: @"1.0", @"2.0", @"3.0", @"4.0", @"5.0", nil];
    self.levelsArray = [[NSMutableArray alloc] initWithObjects: @"000-Level", @"100-Level", @"200-Level", @"300-Level", @"400-Level", @"500-Level", @"600-Level", @"700-Level", @"800-Level", nil];
    self.optionsArray = [[NSMutableArray alloc] init];
    NSMutableArray * array1 = [[NSMutableArray alloc] init];
    NSMutableArray * array2 = [[NSMutableArray alloc] init];
    for (NSString * str in self.unitsArray) {
        [array1 addObject:@0];
    }
    for (NSString * str in self.levelsArray) {
        [array2 addObject:@0];
    }
    [self.optionsArray addObject: array1];
    [self.optionsArray addObject: array2];
    
    [self addSubview:self.courseFilterTableView];
    return self;
}
-(void)showFilter{
    [self show];
}
-(void)hideFilter{
    [self hide];
}

@end
