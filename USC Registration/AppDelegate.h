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
#import "Calendar.h"
@class Term, Section;
@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (strong, nonatomic) TermSchedule * termSchedule;
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSString * term;
@property (strong, nonatomic) Term * termObject;
@property (strong, nonatomic) Calendar * calendar;
@property (nonatomic, strong) MBProgressHUD * progressHUD;
@property (nonatomic, strong) NSMutableDictionary * savedSections;
-(NSString *)URL;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
-(void)addSection:(Section *)section;
-(void)removeSection:(Section *)section;

@end

