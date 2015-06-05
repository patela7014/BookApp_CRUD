//
//  AppDelegate.h
//  Assignment4
//
//  Created by  on 11/23/14.
//  Copyright (c) 2014 MohammedAbdulMoid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TableViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property(nonatomic, retain) UINavigationController *nav;

@property (retain, nonatomic) TableViewController *tablevc;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
