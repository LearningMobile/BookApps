//
//  LMAPhoneTextField.m
//  MyContactList
//
//  Created by Jakob Iversen on 9/15/13.
//  Copyright (c) 2013 Learning Mobile Apps. All rights reserved.
//

#import "LMAPhoneTextField.h"

@implementation LMAPhoneTextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    return _editMode;
}

@end
