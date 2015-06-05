//
//  TableViewController.h
//  Assignment4
//
//  Created by  on 11/23/14.
//  Copyright (c) 2014 Ankur. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddBookViewController.h"
#import <CoreData/CoreData.h>

@class DetailViewController;

@interface TableViewController : UITableViewController<NSFetchedResultsControllerDelegate>

@property (retain, nonatomic) AddBookViewController *add;

@property (retain, nonatomic) NSString *myBooks;
@property (retain, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;

@property (nonatomic, retain) DetailViewController *detailViewController;



@end
