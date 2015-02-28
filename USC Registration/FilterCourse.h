//
//  FilterCourse.h
//  USC Registration
//
//  Created by Vincent Ho on 2/26/15.
//  Copyright (c) 2015 HoLi. All rights reserved.
//

#import "Popup.h"
@protocol FilterCourseDelegate <NSObject>
@required
- (void) filtered: (NSArray*)selections;
@end
@interface FilterCourse : Popup <UITableViewDelegate, UITableViewDataSource>
-(void)showFilter;
-(void)hideFilter;
@property (nonatomic, strong) id <FilterCourseDelegate> delegate;
@property (nonatomic, strong) UITableView * courseFilterTableView;
@property (nonatomic, strong) NSMutableArray * optionsArray;
@property (nonatomic, strong) NSMutableArray * unitsArray;
@property (nonatomic, strong) NSMutableArray * levelsArray;
@property (nonatomic, strong) UIButton * resetButton;
@property(retain)  NSIndexPath* lastIndexPath;
@end
