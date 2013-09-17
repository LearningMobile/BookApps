//
//  LMAMapPoint.m
//  MyContactList
//
//  Created by Iversen, Jakob H on 9/13/13.
//  Copyright (c) 2013 Learning Mobile Apps. All rights reserved.
//

#import "LMAMapPoint.h"

@implementation LMAMapPoint


- (id) init
{
    self = [super init];
    if(self){
        //Initialization code
    }
    return self;
}

-(id) initWithCoordinate:(CLLocationCoordinate2D)location title:(NSString *)contactName subtitle:(NSString *)address
{
    self = [self init];
    if(self)
    {
        _coordinate = location;
        _title = contactName;
        _subtitle = address;
    }
    return self;
}

@end

