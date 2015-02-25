//
//  ViewController.h
//  USC Registration
//
//  Created by hovincen on 2/8/15.
//  Copyright (c) 2015 HoLi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "Term.h"
@interface ViewController : UIViewController<NSURLConnectionDelegate, UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) AppDelegate * appDelegate;
@property (nonatomic, strong) NSMutableData *responseData;
@property (nonatomic, strong) Term * term;
@property (nonatomic, strong) NSDictionary * selectedTerm;
@property (nonatomic, strong) NSArray * terms;
@property (nonatomic, strong) NSMutableArray * isShowingList;
@property (nonatomic, assign) NSInteger openSectionIndex;
@property (nonatomic) BOOL doneConnecting;

@property (weak, nonatomic) IBOutlet UIImageView *animatedLogoImageView;
@property (weak, nonatomic) IBOutlet UIView *logoViewBackground;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UILabel *loadingLabel;
@property (nonatomic) BOOL shownBefore;
@property (nonatomic) BOOL buttonClicked;
@property (nonatomic) BOOL tableViewCollapsed;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIImageView *uscIcon;
@property (strong, nonatomic) IBOutlet UILabel *chooseLabel;

@end

