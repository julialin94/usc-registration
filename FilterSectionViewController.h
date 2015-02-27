//
//  FilterSectionViewController.h
//  USC Registration
//
//  Created by Vincent Ho on 2/24/15.
//  Copyright (c) 2015 HoLi. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol FilterSectionViewControllerDelegate <NSObject>
@required
- (void) filteredWithCriteria:(NSMutableArray *)criteria;
@end

@interface FilterSectionViewController : UIViewController

@property (nonatomic, strong) id delegate;
@property (nonatomic, strong) NSMutableArray * filter;
@end
