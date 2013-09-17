//
//  LMASecondViewController.m
//  My ContactList
//
//  Created by Iversen, Jakob H on 8/29/13.
//  Copyright (c) 2013 Learning Mobile Apps. All rights reserved.
//

#import "LMASecondViewController.h"

@interface LMASecondViewController ()

@end

@implementation LMASecondViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    //UIScrollView *tempScrollView=(UIScrollView *)self.view;
    _sv1.contentSize=CGSizeMake(325,1000);
}
//-(void)viewWillAppear:(BOOL)animated{
//    _sv1.contentSize=CGSizeMake(325,1000);
//
//}
-(void)viewDidLayoutSubviews
{
    _sv1.contentSize=CGSizeMake(325,1000);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
