//
//  TableViewController.m
//  Assignment4
//
//  Created by  on 11/23/14.
//  Copyright (c) 2014 Ankur. All rights reserved.
//

#import "TableViewController.h"
#import "AddBookViewController.h"
#import "AppDelegate.h"
#import "MyBooks.h"
#import "DetailViewController.h"

@interface TableViewController ()

@end

@implementation TableViewController
@synthesize add;
@synthesize managedObjectContext, myBooks,fetchedResultsController,detailViewController;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.title=@"Books List";
    
    UIBarButtonItem *addBtn = [[UIBarButtonItem alloc] initWithTitle:@"Add" style:UIBarButtonItemStylePlain target:self action:@selector(addBook)];
    self.navigationItem.rightBarButtonItem = addBtn;
    
        
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    self.managedObjectContext = appDelegate.managedObjectContext;
    
    
    //Create the fetch request
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    //create reference to the Books entity
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"MyBooks"
                                              inManagedObjectContext:[self managedObjectContext]];
    
    //in what order you want your data to be fetched
    NSSortDescriptor *dateSort = [[NSSortDescriptor alloc] initWithKey:@"dueDate"
                                                             ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects: dateSort, nil];
    fetchRequest.sortDescriptors = sortDescriptors;
    
    //tell the request that we want to read the contents of the Books entity
    [fetchRequest setEntity:entity];
    
    //initialize a fetched results controller to efficiently manage the results
    //returned from a Core Data fetch request
    self.fetchedResultsController = [[NSFetchedResultsController alloc]
                     initWithFetchRequest:fetchRequest
                     managedObjectContext:[self managedObjectContext]
                     sectionNameKeyPath:nil
                     cacheName:nil];
    //notify the view controller when the fetched results change
    self.fetchedResultsController.delegate = self;
    
    NSError *fetchingError = nil;
    //perform the fetch request
    if ([self.fetchedResultsController performFetch:&fetchingError]){
        NSLog(@"Successfully fetched data from Books entity");
    }
    else {
        NSLog(@"Failed to fetch any data from the Books entity");
    }



}

//notify the receiver that the fetched results controller has completed processing
//of one or more changes due to an add, remove, move, or update
- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller{
    [self.tableView reloadData];
}



-(void) addBook
{
    self.add=[[AddBookViewController alloc] initWithNibName:@"AddBookViewController" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:add animated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [self.tableView beginUpdates]; // Avoid  NSInternalInconsistencyException
        
        // Delete the role object that was swiped
        MyBooks *bookToDelete = [self.fetchedResultsController objectAtIndexPath:indexPath];
        NSLog(@"Deleting (%@)", bookToDelete.title);
        [self.managedObjectContext deleteObject:bookToDelete];
        [self.managedObjectContext save:nil];
        
        // Delete the (now empty) row on the table
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
      //  [self performFetch];
        
        [self.tableView endUpdates];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
return [[fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id  sectionInfo =[[fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    
    
    
    
    
    UITableViewCell *myCell = nil;
    static NSString *BooksCell = @"Cell";
    
    //create a reusable table-view cell object located by its identifier
    myCell = [tableView dequeueReusableCellWithIdentifier:BooksCell];
    if (myCell == nil){
        myCell =
        [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                               reuseIdentifier:BooksCell];
        myCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    //get the Books object at the given index path in the fetch results
    MyBooks *books = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    //display text for the cell view
    myCell.textLabel.text = [NSString stringWithFormat:@"%@", books.title];
    
    //set the accessory view to be a clickable button
    myCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return myCell;
    
    
    
    
    
    
    
    
    
}






- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    MyBooks *book=[self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text=book.title;
    cell.detailTextLabel.text=[NSString stringWithFormat:@"%@, %@",
                                 book.libName, book.dueDate];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!self.detailViewController)
        self.detailViewController = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
    
    MyBooks *book = [[self fetchedResultsController] objectAtIndexPath:indexPath];
    self.detailViewController.book = book;
    self.detailViewController.context = self.fetchedResultsController.managedObjectContext;
    [self.navigationController pushViewController:self.detailViewController animated:YES];
}




-(void) dealloc{[super dealloc]; [add release]; [managedObjectContext release]; [myBooks release];
    [detailViewController release];
}


@end
