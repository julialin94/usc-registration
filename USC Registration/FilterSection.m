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
    if (section == 1) return 2;
    if (section == 2) return 2;
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

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    NSString * title = nil;
    switch (section) {
        case 0:
            title = @"Exclude Days";
            break;
        case 1:
            title = @"Starting After";
            break;
        case 2:
            title = @"Ending Before";
            break;
        case 3:
            title = @"Has Available Seats";
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
    else if (selected) {
        cell.accessoryType = UITableViewCellAccessoryNone;
        [(NSMutableArray *)self.optionsArray[indexPath.section] replaceObjectAtIndex:indexPath.row withObject:@(1)];
    }
    else if (selected) {
        cell.accessoryType = UITableViewCellAccessoryNone;
        [(NSMutableArray *)self.optionsArray[indexPath.section] replaceObjectAtIndex:indexPath.row withObject:@(2)];
    }
    else{
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        [(NSMutableArray *)self.optionsArray[indexPath.section] replaceObjectAtIndex:indexPath.row withObject:@(3)];
    }
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
    self.timesAfterArray = [[NSMutableArray alloc] initWithObjects: @"Morning", @"Afternoon", nil];
    self.timesBeforeArray = [[NSMutableArray alloc] initWithObjects: @"Morning", @"Afternoon", nil];
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

    
    return self;
}
-(void)showFilter{
    [self show];
}
-(void)hideFilter{
    [self hide];
}

@end
