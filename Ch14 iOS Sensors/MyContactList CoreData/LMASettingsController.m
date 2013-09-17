//
//  LMASettingsController.m
//  MyContactList CoreData
//
//  Created by Jakob Iversen on 9/9/13.
//  Copyright (c) 2013 Learning Mobile Apps. All rights reserved.
//

#import "LMASettingsController.h"
#import "Constants.h"
#import <CoreMotion/CoreMotion.h>

@interface LMASettingsController ()

@end

@implementation LMASettingsController

NSArray *sortOrderItems;

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
    sortOrderItems = @[@"contactName", @"city", @"birthday"];
    _pckSortField.dataSource = self;
    _pckSortField.delegate = self;
    //set the UI based on values in NSUserDefaults
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    
    BOOL sortAscending =[settings boolForKey:kSortDirectionAscending];
    [_swAscending setOn:sortAscending];
    NSString *sortField = [settings objectForKey:kSortField];
    int i = 0;
    for (NSString *field in sortOrderItems) {
        if([field isEqualToString:sortField]) {
            [_pckSortField selectRow:i inComponent:0 animated:NO];
        }
        i++;
    }
    [_pckSortField reloadComponent:0];
    UIDevice *device = [UIDevice currentDevice];                                  //1
    device.batteryMonitoringEnabled = YES;                                        //2
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(batteryChanged:)//3
                                                 name:@"UIDeviceBatteryLevelDidChangeNotification"
                                               object:device];
    [[NSNotificationCenter defaultCenter]                                         //4
     addObserver:self
     selector:@selector(batteryChanged:)
     name:@"UIDeviceBatteryStateDidChangeNotification"
     object:device];
    _lblBattery.text = [self batteryStatus];                                       //5
}


- (void)viewWillAppear:(BOOL)animated
{
    UIDevice *device = [UIDevice currentDevice];                             //1
    NSLog(@"Device Info:");
    NSLog(@"Name: %@", device.name);                                         //2
    NSLog(@"Model: %@", device.model);                                       //3
    NSLog(@"System Name: %@", device.systemName);                            //4
    NSLog(@"System Version: %@", device.systemVersion);                      //5
    NSLog(@"Identifier: %@", device.identifierForVendor);                    //6
    NSString *orientation;
    switch (device.orientation) {                                            //7
        case UIDeviceOrientationFaceDown:
            orientation = @"Face Down";
            break;
        case UIDeviceOrientationLandscapeLeft:
            orientation = @"Landscape Left";
            break;
        case UIDeviceOrientationPortrait:
            orientation = @"Portrait";
            break;
        case UIDeviceOrientationFaceUp:
            orientation = @"Face Up";
            break;
        case UIDeviceOrientationLandscapeRight:
            orientation = @"Landscape Right";
            break;
        case UIDeviceOrientationPortraitUpsideDown:
            orientation = @"Portrait Upside Down";
            break;
        case UIDeviceOrientationUnknown:
            orientation = @"Unknown";
            break;
        default:
            break;
    }
    NSLog(@"Orientation: %@", orientation);
        [self startMotionDetection];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [[self motionManager] stopAccelerometerUpdates];
}

- (void)batteryChanged:(NSNotification *)notification                             //1
{
    _lblBattery.text = [self batteryStatus];
}

-(NSString *) batteryStatus
{
    UIDevice *device = [UIDevice currentDevice];                                  //2
    
    NSString *batteryState;
    switch (device.batteryState) {                                                //3
        case UIDeviceBatteryStateCharging:
            batteryState = @"+";
            break;
        case UIDeviceBatteryStateFull:
            batteryState = @"!";
            break;
        case UIDeviceBatteryStateUnplugged:
            batteryState = @"-";
            break;
        default:
            batteryState = @"?";
            break;
    }
    float batteryLevelPercent = device.batteryLevel * 100;                        //4
    NSString *batteryLevel = [NSString stringWithFormat:@"%.0f%%",                //5
                              batteryLevelPercent];
    NSString *batteryStatus = [NSString stringWithFormat:@"%@ (%@)",              //6
                               batteryLevel, batteryState];
    return batteryStatus;
}

-(CMMotionManager *)motionManager
{
    CMMotionManager *motionMManager = nil;                                        //1
    id appDelegate = [[UIApplication sharedApplication] delegate];                //2
    if([appDelegate respondsToSelector:@selector(motionManager)]) {               //3
        motionMManager = [appDelegate motionManager];
    }
    return motionMManager;
}
-(void) startMotionDetection
{
    CMMotionManager *mManager = [self motionManager];                             //1
    [mManager setAccelerometerUpdateInterval:0.05];                               //2
    [mManager startAccelerometerUpdatesToQueue:[[NSOperationQueue alloc]init]     //3
                                   withHandler:^(CMAccelerometerData *data, NSError *error)
     {
         dispatch_async(dispatch_get_main_queue(),^{                              //4
             [self updateLabel:data];                                             //5
         });
     }
     ];
}

-(void) updateLabel: (CMAccelerometerData *) data
{
    float moveFactor = 15;                                                        //1
    CGRect rect = _lblBattery.frame;//2
    float moveToX = rect.origin.x + (data.acceleration.x * moveFactor);           //3
    float moveToY = (rect.origin.y + rect.size.height) -(data.acceleration.y * moveFactor);
    float maxX = self.view.frame.size.width - rect.size.width;                    //5
    float maxY = self.view.frame.size.height;                                     //6
    if(moveToX > 0 && moveToX < maxX){                                            //7
        rect.origin.x += (data.acceleration.x * moveFactor);
    }
    if(moveToY > rect.size.height && moveToY < maxY){                             //8
        rect.origin.y -= (data.acceleration.y * moveFactor);
    }
    [UIView animateWithDuration:0 delay:0                                         //9
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{ _lblBattery.frame = rect; }
                     completion:nil];
   
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sortDirectionChanged:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:_swAscending.isOn forKey:kSortDirectionAscending];
}

#pragma mark - UIPickerView DataSource
// Returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// Returns the # of rows in the picker
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [sortOrderItems count];
}

//Sets the value that is shown for each row in the picker
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [sortOrderItems objectAtIndex:row];
}

//If the user chooses from the pickerview, it calls this function;
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSString *sortField = [sortOrderItems objectAtIndex:row];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:sortField forKey:kSortField];
    [defaults synchronize];
}

@end
