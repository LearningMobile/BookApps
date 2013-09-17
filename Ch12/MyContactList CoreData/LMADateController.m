//
//  LMADateController.m
//  MyContactList CoreData
//
//  Created by Jakob Iversen on 9/6/13.
//  Copyright (c) 2013 Learning Mobile Apps. All rights reserved.
//

#import "LMADateController.h"

@interface LMADateController ()

@end

@implementation LMADateController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    UIBarButtonItem *saveButton =
                  [[UIBarButtonItem alloc]
                      initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                      target:self
                      action:@selector(saveDate:)];
    [self.navigationItem setRightBarButtonItem:saveButton];
    self.title = @"Pick Birthdate";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)saveDate: (id)sender
{
    [_delegate dateChanged:[_dtpDate date]];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
