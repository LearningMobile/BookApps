//
//  LMAAppDelegate.h
//  MyContactList CoreData
//
//  Created by COB User on 10/24/13.
//  Copyright (c) 2013 Learning Mobile Apps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LMAAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
