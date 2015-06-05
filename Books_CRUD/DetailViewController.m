//
//  DetailViewController.m
//  Assignment4
//
//  Created by  on 11/25/14.
//  Copyright (c) 2014 MohammedAbdulMoid. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController
@synthesize lbldue,lbllibrary,lbltitle,context,btnUpdate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        UIBarButtonItem *editBtn = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(EditBook)];
        self.navigationItem.rightBarButtonItem = editBtn;
        
        
        
    }
    return self;
}

-(void)EditBook
{
    lbltitle.enabled=true;
    lbldue.enabled=true;
    lbllibrary.enabled=true;
    btnUpdate.hidden =NO;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self configureView];
}

- (void)configureView
{
    if (self.book)
    {
        self.lbltitle.text = self.book.title;
        lbltitle.enabled=false;
        self.lbllibrary.text = self.book.libName;
        lbllibrary.enabled=false;
       
    //    self.lbldue.text = [self.book.dueDate description];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"dd-MM-yyyy"];
        NSString *stringDate = [dateFormatter stringFromDate:self.book.dueDate];
        self.lbldue.text =stringDate;
        lbldue.enabled=false;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    btnUpdate.hidden=YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    [tap autorelease];

}

-(void)dismissKeyboard {
    
    [lbltitle resignFirstResponder];
    
    [lbllibrary resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.lbltitle) {
        [lbltitle resignFirstResponder];
    }
    
    if (textField == self.lbllibrary) {
        [lbllibrary resignFirstResponder];
    }
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [context release];
    [lbltitle release];
    [lbllibrary release];
    [lbldue release];
    [super dealloc];
}
- (IBAction)btnUpdate:(id)sender {
    
//    [MyBooks setValue:self.lbltitle.text forKey:@"title"];
//    [MyBooks setValue:self.lbllibrary.text forKey:@"libName"];
//    [MyBooks setValue:self.lbldue.text forKey:@"dueDate"];
//    
//    NSError *error;
//    
//    if (![context save:&error])
//    {
//        NSLog(@"Problem saving: %@", [error localizedDescription]);
//    }
    
    
    
    self.book.title = self.lbltitle.text;
    self.book.libName = self.lbllibrary.text;
  //  self.book.dueDate = [self.lbldue.text description];
    
    NSString *dateString = self.lbldue.text;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // this is imporant - we set our input date format to match our input string
    // if format doesn't match you'll get nil from your string, so be careful
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    NSDate *dateFromString = [[NSDate alloc] init];
    // voila!
    dateFromString = [dateFormatter dateFromString:dateString];
    self.book.dueDate=dateFromString;
    
    NSError __autoreleasing *error;
    BOOL saveSuccessful = [self.context save:&error];
    if (!saveSuccessful)
        NSLog(@"Error saving, Error: %@", error.localizedDescription);
    [self.navigationController popViewControllerAnimated:YES];
}
@end
