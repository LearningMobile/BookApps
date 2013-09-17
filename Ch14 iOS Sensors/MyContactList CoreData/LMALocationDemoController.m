//
//  LMASecondViewController.m
//  My ContactList
//
//  Created by Iversen, Jakob H on 8/29/13.
//  Copyright (c) 2013 Learning Mobile Apps. All rights reserved.
//

#import "LMALocationDemoController.h"


@interface LMALocationDemoController ()

@end
    CLLocationManager *locationManager;

@implementation LMALocationDemoController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    //UIScrollView *tempScrollView=(UIScrollView *)self.view;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addressToCoordinates:(id)sender {
    NSString *address = [NSString stringWithFormat:@"%@, %@ %@",
                         _txtStreetAddress.text, _txtCity.text, _txtState.text];
    
    CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
    [geoCoder geocodeAddressString:address completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark *bestMatch = [placemarks objectAtIndex:0];
        CLLocationCoordinate2D coordinate = bestMatch.location.coordinate;
        _lblLatitude.text = [NSString stringWithFormat:@"%g\u00B0",
                             coordinate.latitude];
        _lblLongitude.text = [NSString stringWithFormat:@"%g\u00B0",
                              coordinate.longitude];
    }];
}

- (IBAction)deviceCoordinates:(id)sender {
    if(locationManager == nil)
        locationManager = [[CLLocationManager alloc]init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    locationManager.distanceFilter = 100;
    [locationManager startUpdatingLocation];
    [locationManager startUpdatingHeading];
}


-(void)viewDidDisappear:(BOOL)animated{
    [locationManager stopUpdatingLocation];
    [locationManager stopUpdatingHeading];
}

- (IBAction)dismissKeyboard:(id)sender
{
    [self.view endEditing:YES];
}

-(void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    CLLocation *location = [locations lastObject];
    NSDate* eventDate = location.timestamp;
    NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
    if (abs(howRecent) < 15.0) {
        CLLocationCoordinate2D coordinate= location.coordinate;
        _lblLongitude.text = [NSString stringWithFormat:@"%g\u00B0",
                              coordinate.longitude];
        _lblLatitude.text = [NSString stringWithFormat:@"%g\u00B0",
                             coordinate.latitude];
        _lblLocationAccuracy.text = [NSString stringWithFormat:@"%gm",
                                     location.horizontalAccuracy];
        _lblAltitude.text = [NSString stringWithFormat:@"%gm",
                             location.altitude];
        _lblAltitudeAccuracy.text = [NSString stringWithFormat:@"%gm",
                                     location.verticalAccuracy];
    }
}

-(void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading
{
    if(newHeading.headingAccuracy > 0){
        CLLocationDirection theHeading = newHeading.trueHeading;
        _lblHeading.text = [NSString stringWithFormat:@"%g\u00B0", theHeading];
        _lblHeadingAccuracy.text = [NSString stringWithFormat:@"%g\u00B0",
                                    newHeading.headingAccuracy];
    }
}

-(void) locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSString *errorType = (error.code == kCLErrorDenied) ? @"Access Denied" : @"Unknown Error";
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"Error Getting Location"
                          message:errorType
                          delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil];
    [alert show];
}



@end
