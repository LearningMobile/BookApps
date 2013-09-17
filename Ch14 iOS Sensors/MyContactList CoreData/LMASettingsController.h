//
//  LMASettingsController.h
//  MyContactList CoreData
//
//  Created by Jakob Iversen on 9/9/13.
//  Copyright (c) 2013 Learning Mobile Apps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LMASettingsController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate> 
@property (weak, nonatomic) IBOutlet UIPickerView *pckSortField;
@property (weak, nonatomic) IBOutlet UISwitch *swAscending;
- (IBAction)sortDirectionChanged:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *lblBattery;
@end
