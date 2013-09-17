//
//  LMAMapController.h
//  MyContactList
//
//  Created by Jakob Iversen on 9/13/13.
//  Copyright (c) 2013 Learning Mobile Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface LMAMapController : UIViewController <MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mvMap;
@property (nonatomic) NSArray *contacts;
@property (weak, nonatomic) IBOutlet UISegmentedControl *sgmtMapType;
- (IBAction)mapTypeChanged:(id)sender;

@end
