//
//  VHTermViewController.h
//  USC Registration
//
//  Created by Vincent Ho on 2/11/15.
//  Copyright (c) 2015 HoLi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Term.h"  
#import "AppDelegate.h"
#import "Department.h"
@interface VHTermViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) AppDelegate * appDelegate;
@property (weak, nonatomic) IBOutlet UILabel *schoolLabel;
@property (weak, nonatomic) IBOutlet UILabel *prefixLabel;
@property (weak, nonatomic) IBOutlet UILabel *departmentLabel;
@property (weak, nonatomic) IBOutlet UIView *menuView;
@property (strong, nonatomic) UIView *lineView;
@property (strong, nonatomic) UIView *trackView;
@property (strong, nonatomic) UIView *blurView;
@property (strong, nonatomic) Term * term;
@property (strong, nonatomic) Department * selectedDepartment;
@property (strong, nonatomic) School * selectedSchool;
@property (nonatomic) NSInteger index;
@property (nonatomic) NSInteger lastIndex;
@property (nonatomic, strong) NSMutableArray * arrayOfLabels;
@property (nonatomic, strong) NSArray * arrayOfNavigationBarButtons;
@property (nonatomic, strong) NSDictionary * schools;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UICollectionView *schoolCollectionView;
- (IBAction)backAction:(id)sender;


@end
