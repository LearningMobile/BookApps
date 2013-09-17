//
//  LMABook.m
//  Objective-C Examples
//
//  Created by Jakob Iversen on 7/18/13.
//  Copyright (c) 2013 Learning Mobile Apps. All rights reserved.
//

#import "LMABook.h"

@implementation LMABook

- (id) init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    return self;
}

-(id) initWithTitle:(NSString *)aTitle
{
    self = [super init];
    if(self) {
        _title = [aTitle copy];
    }
    return self;
}

+(id) bookWithTitle:(NSString *)aTitle
{
    LMABook *book = [[self alloc] initWithTitle:aTitle];
    return book;
}

+(id) bookWithTitle:(NSString *)aTitle andAuthor:(NSString *)anAuthor
{
    LMABook *book = [[self alloc] initWithTitle:aTitle];
    book.author = anAuthor;
	//or: [book setAuthor:anAuthor];
    return book;
}

-(void) lendOut:(NSString *)lenderName
{
    _lender = lenderName;
    _out = YES;
}

-(void) returnBook
{
    _lender = nil;
    _out = NO;
}

@end
