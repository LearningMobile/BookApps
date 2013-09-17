//
//  LMAViewController.m
//  Hello World!
//
//  Created by Jakob Iversen on 8/16/13.
//  Copyright (c) 2013 Learning Mobile Apps. All rights reserved.
//

#import "LMAViewController.h"

@interface LMAViewController ()

@end

@implementation LMAViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showOutput:(id)sender {
    NSString *name = [_txtName text];
    NSString *output = [NSString stringWithFormat:@"Hello %@!", name];
    _lblOutput.text = output;
}

//Dismiss keyboard
- (IBAction)backgroundTap:(id)sender
{
    [self.view endEditing:YES];
}

@end
