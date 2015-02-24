//
//  AppDelegate.h
//  USC Registration
//
//  Created by hovincen on 2/8/15.
//  Copyright (c) 2015 HoLi. All rights reserved.
//  test

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "MBProgressHUD.h"
#import "TermSchedule.h"
@class Term;
@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (strong, nonatomic) TermSchedule * termSchedule;
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSString * term;
@property (strong, nonatomic) Term * termObject;
@property (nonatomic, strong) MBProgressHUD * progressHUD;
-(NSString *)URL;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end

