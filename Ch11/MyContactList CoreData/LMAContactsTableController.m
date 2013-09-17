//
//  LMAContactsTableController.m
//  MyContactList CoreData
//
//  Created by Jakob Iversen on 9/10/13.
//  Copyright (c) 2013 Learning Mobile Apps. All rights reserved.
//

#import "LMAContactsTableController.h"

#import "Contact.h"
#import "LMAAppDelegate.h"
#import "LMAContactsController.h"
#import "Constants.h"

@interface LMAContactsTableController ()

@end

NSArray *contacts;

LMAAppDelegate *appDelegate;
NSManagedObjectContext *context;

LMAContactsController *contactController;

@implementation LMAContactsTableController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
//    contacts = @[@"Jim", @"John", @"Dana", @"Rosie", @"Justin", @"Jeremy",
//                 @"Sarah", @"Matt", @"Joe", @"Donald", @"Jeff"];
        [self loadDataFromDatabase];
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadDataFromDatabase];
    [self.tableView reloadData];
}

#pragma mark - Core Data methods
- (void) loadDataFromDatabase
{
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    NSString *sortField = [settings stringForKey:kSortField];
    bool sortAscending = [settings boolForKey:kSortDirectionAscending];
    
    appDelegate = [[UIApplication sharedApplication] delegate];
    context = [appDelegate managedObjectContext];
    NSEntityDescription *entityDescription = [NSEntityDescription
                                              entityForName:@"Contact"
                                              inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    //Specify sorting
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]
                                        initWithKey:sortField
                                        ascending:sortAscending];
    NSArray *sortDescriptors = [[NSArray alloc]
                                initWithObjects: sortDescriptor, nil] ;
    request.sortDescriptors = sortDescriptors;
    
    NSError *error;
    
    contacts = [[NSArray alloc]
                initWithArray:[context executeFetchRequest:request
                                                     error:&error]];
}







- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [contacts count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ContactsCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
//    if(cell==nil){
//        cell = [[UITableViewCell alloc]
//                initWithStyle:UITableViewCellStyleSubtitle
//                reuseIdentifier:CellIdentifier];
//    }
    Contact *contact = [contacts objectAtIndex:[indexPath row] ];
    cell.textLabel.text = [contact contactName];
    cell.detailTextLabel.text = [contact city];
    return cell;
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        Contact *contactToDelete = [contacts objectAtIndex:[indexPath row]];
        [context deleteObject:contactToDelete];
        NSError *error;
        [context save:&error];
        [self loadDataFromDatabase];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"EditContact"]) {
        contactController = segue.destinationViewController;
    }
    
}

-(void) tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    Contact *selectedContact = [contacts objectAtIndex:[indexPath row]];
    contactController.contact = selectedContact;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    int selectedRow = [indexPath row];
   // NSIndexPath *selectedPath = [self.tableView indexPathForSelectedRow];
    Contact *selectedContact = [contacts objectAtIndex:selectedRow];
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"Contact Selected"
                          message:[NSString
                                   stringWithFormat:@"Selected row: %d (%@)",
                                   selectedRow, selectedContact.contactName]
                          delegate:self
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:@"Show Details", nil];
    [alert show];
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 1){
        LMAContactsController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"contactController"];
        NSIndexPath *selectedPath = [self.tableView indexPathForSelectedRow];
        Contact *selectedContact = [contacts objectAtIndex:[selectedPath row]];
        controller.contact = selectedContact;
        [self.navigationController pushViewController:controller animated:YES];
    }
}

@end
