//
//  FilterSection.h
//  USC Registration
//
//  Created by Vincent Ho on 2/26/15.
//  Copyright (c) 2015 HoLi. All rights reserved.
//

#import "Popup.h"

@interface FilterSection : Popup <UITableViewDelegate, UITableViewDataSource>
-(void)showFilter;
-(void)hideFilter;
@property (nonatomic, strong) UITableView * sectionFilterTableView;
@property (nonatomic, strong) NSMutableArray * optionsArray;
@property (nonatomic, strong) NSMutableArray * daysArray;
@property (nonatomic, strong) NSMutableArray * timesAfterArray;
@property (nonatomic, strong) NSMutableArray * timesBeforeArray;
@property (nonatomic, strong) NSMutableArray * availableArray;
@property(retain)  NSIndexPath* lastIndexPath;
@end
