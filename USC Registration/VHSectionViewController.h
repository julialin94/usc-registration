//
//  VHSectionViewController.h
//  USC Registration
//
//  Created by Vincent Ho on 2/24/15.
//  Copyright (c) 2015 HoLi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Section.h"
#import "AppDelegate.h"
@interface VHSectionViewController : UIViewController
- (IBAction)addSectionAction:(id)sender;
@property (nonatomic, strong) Section * section;
@property (nonatomic, strong) AppDelegate * appDelegate;
@end
