//
//  AddBookViewController.h
//  Assignment4
//
//  Created by  on 11/23/14.
//  Copyright (c) 2014 Ankur. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TableViewController;
@interface AddBookViewController : UIViewController

@property (retain, nonatomic) IBOutlet UITextField *bookName;

@property (retain, nonatomic) IBOutlet UITextField *libName;

@property (retain, nonatomic) IBOutlet UIDatePicker *dueDate;


@property (retain, nonatomic) NSString *myBooks;

@property (retain, nonatomic) NSManagedObjectContext *managedObjectContext;

@property(nonatomic, retain) TableViewController *tableViewController;


- (IBAction)Save:(id)sender;

@end
