//
//  LMAFirstViewController.m
//  My ContactList
//
//  Created by Iversen, Jakob H on 8/29/13.
//  Copyright (c) 2013 Learning Mobile Apps. All rights reserved.
//

#import "LMAContactsController.h"
#import "LMADateController.h"
#import "LMAAppDelegate.h"

@interface LMAContactsController () <LMADateControllerDelegate>

@end

@implementation LMAContactsController

NSDate *birthdate;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    _scrollView.contentSize = CGSizeMake(320,500);
    
    UIBarButtonItem *saveButton =
                [[UIBarButtonItem alloc]
                        initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                        target:self
                        action:@selector(saveContact:)];
    [self.navigationItem setRightBarButtonItem:saveButton];
    self.title = @"Contact";
    [self changeEditMode:self];
    
    if(_contact){
        _txtName.text = _contact.contactName;
        _txtAddress.text = _contact.streetAddress;
        _txtCity.text = _contact.city;
        _txtState.text = _contact.state;
        _txtZip.text = _contact.zipCode;
        _txtPhone.text = _contact.phoneNumber;
        _txtCell.text = _contact.cellNumber;
        _txtEmail.text = _contact.email;
        [self dateChanged:_contact.birthday];
        [_sgmtEditMode setSelectedSegmentIndex:0]; //set to view mode
        [self changeEditMode:self];
    }
}


-(void)viewDidLayoutSubviews
{
    _scrollView.contentSize = CGSizeMake(320,500);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)backgroundTap:(id)sender
{
    [self.view endEditing:YES];
}

- (IBAction)changeEditMode:(id)sender {
    NSArray *textFields = @[_txtName, _txtAddress, _txtCity, _txtState,
                            _txtZip, _txtPhone, _txtCell, _txtEmail];
    if (_sgmtEditMode.selectedSegmentIndex == 0){
        for (UITextField *txtfield in textFields) {
            [txtfield setEnabled:NO];
            [txtfield setBorderStyle:UITextBorderStyleNone];
        }
        [_btnChange setHidden:YES];
    }
    else if (_sgmtEditMode.selectedSegmentIndex == 1)
    {
        for (UITextField *txtfield in textFields) {
            [txtfield setEnabled:YES];
            [txtfield setBorderStyle:UITextBorderStyleRoundedRect];
        }
        [_btnChange setHidden:NO];
    }
}



-(void)dateChanged:(NSDate *) date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [_lblBirthdate setText:[dateFormatter stringFromDate:date ]];
    birthdate = date;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"segueContactDate"]) {
        LMADateController *dateController = segue.destinationViewController;
        dateController.delegate = self;
    }
}

-(IBAction)saveContact: (id)sender
{
    LMAAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
//    Contact *contact = [NSEntityDescription
//                        insertNewObjectForEntityForName:@"Contact"
//                        inManagedObjectContext:context];
    if(!_contact){
        _contact = [NSEntityDescription
                   insertNewObjectForEntityForName:@"Contact"
                   inManagedObjectContext:context];
    }
    NSError *error;
    [_contact setValue:_txtName.text forKey:@"contactName"];
    [_contact setValue:_txtAddress.text forKey:@"streetAddress"];
    [_contact setValue:_txtCity.text forKey:@"city"];
    [_contact setValue:_txtState.text forKey:@"state"];
    [_contact setValue:_txtZip.text forKey:@"zipCode"];
    [_contact setValue:_txtPhone.text forKey:@"phoneNumber"];
    [_contact setValue:_txtCell.text forKey:@"cellNumber"];
    [_contact setValue:_txtEmail.text forKey:@"email"];
    [_contact setValue:birthdate forKey:@"birthday"];
    
    [context save:&error];
    if(error !=nil) {
        NSLog(@"Error saving object: %@", error.description);
    }
    else {
        NSLog(@"Object saved successfully");
    }
}
@end
