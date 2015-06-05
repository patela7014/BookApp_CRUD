//
//  DetailViewController.h
//  Assignment4
//
//  Created by  on 11/25/14.
//  Copyright (c) 2014 MohammedAbdulMoid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyBooks.h"

@interface DetailViewController : UIViewController
@property (retain, nonatomic) IBOutlet UITextField *lbltitle;
@property (retain, nonatomic) IBOutlet UITextField *lbllibrary;
@property (retain, nonatomic) IBOutlet UITextField *lbldue;

@property (nonatomic, strong) MyBooks *book;
@property (nonatomic, strong) NSManagedObjectContext *context;

@property (nonatomic, strong) IBOutlet UIButton *btnUpdate;
- (IBAction)btnUpdate:(id)sender;


@end
