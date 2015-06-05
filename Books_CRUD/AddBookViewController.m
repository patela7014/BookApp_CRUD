//
//  AddBookViewController.m
//  Assignment4
//
//  Created by  on 11/23/14.
//  Copyright (c) 2014 Ankur. All rights reserved.
//

#import "AddBookViewController.h"
#import "AppDelegate.h"
#import "MyBooks.h"

@interface AddBookViewController ()

@end

@implementation AddBookViewController

@synthesize bookName;
@synthesize libName;
@synthesize dueDate,tableViewController;

@synthesize managedObjectContext, myBooks;





- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewDidAppear:(BOOL)animated
{
    [self viewDidLoad];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    [tap autorelease];
    
    AppDelegate *appDelegate=[[UIApplication sharedApplication] delegate];
    self.managedObjectContext = appDelegate.managedObjectContext;
}

-(void)dismissKeyboard {
    
    [bookName resignFirstResponder];
    
    [libName resignFirstResponder];
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.bookName) {
        [bookName resignFirstResponder];
    }
    
    if (textField == self.libName) {
        [libName resignFirstResponder];
    }
    return YES;
}


-(BOOL) createBookWithTitle:(NSString *)title libraryName:(NSString *)libraryName due:(NSDate *)due
{
    BOOL success = NO;
    if ([title length] == 0){
        NSLog(@"Title is mandatory.");
        return NO;
    }
    
    if ([libraryName length] == 0){
        NSLog(@"Library name is mandatory.");
        return NO;
    }
    
    
    
    MyBooks *myBooksObj=(MyBooks *) [NSEntityDescription insertNewObjectForEntityForName:@"MyBooks" inManagedObjectContext:managedObjectContext];
    
    [myBooksObj setLibName:libraryName];
    
    [myBooksObj setTitle:title];
    
    [myBooksObj setDueDate:due];
    
    NSError *error;if(![managedObjectContext save:&error])
    {
        // Handle the error.
        exit(0);
    }
    return success;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [tableViewController release];
    [bookName release];
    [libName release];
    [dueDate release];
    [super dealloc];
}

- (IBAction)Save:(id)sender {
    [self createBookWithTitle:bookName.text libraryName:libName.text due:dueDate.date];
    [tableViewController.tableView reloadData];
    [self.navigationController popViewControllerAnimated:YES];
}
@end
