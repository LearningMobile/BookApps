//
//  LMAAppDelegate.m
//  Objective-C Examples
//
//  Created by Jakob Iversen on 7/18/13.
//  Copyright (c) 2013 Learning Mobile Apps. All rights reserved.
//

#import "LMAAppDelegate.h"
#import "LMABook.h"

@implementation LMAAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    LMABook *book1 = [[LMABook alloc] init];
    book1.title = @"Moby Dick";
    book1.author = @"Herman Melville";
    book1.pages = 899;
    
    LMABook *book2 = [LMABook bookWithTitle:@"To Kill A Mockingbird"
                                 andAuthor:@"Harper Lee"];
    [book2 setPages:359];
    
    [book1 lendOut:@"Jim Smith"];
    [book2 lendOut:@"Mary Jane"];
    [book2 returnBook];
    
    
    if([book1 isOut]){
        NSLog(@"%@ is lent out to %@", book1.title, book1.lender);
    }
    else {
        NSLog(@"%@ is not lent out", book1.title);
    }
    
    NSArray *books = @[book1, book2];
    
    for (LMABook *book in books) {
        NSLog(@"%@, %d pages.", book.title, book.pages);
    }
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
