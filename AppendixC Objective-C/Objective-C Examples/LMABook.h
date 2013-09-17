//
//  LMABook.h
//  Objective-C Examples
//
//  Created by Jakob Iversen on 7/18/13.
//  Copyright (c) 2013 Learning Mobile Apps. All rights reserved.
//

    #import <Foundation/Foundation.h>

    @interface LMABook : NSObject

    @property (readwrite, strong) NSString *title;
    @property (readwrite, weak) NSString *author;
    @property (readonly, nonatomic, strong) NSString *lender;
    @property (getter = isOut) BOOL out;
    @property int pages;

    - (id) initWithTitle: (NSString *)aTitle;
    + (id) bookWithTitle: (NSString *)aTitle andAuthor:(NSString *)anAuthor;
    - (void) lendOut: (NSString *)lenderName;
    - (void) returnBook;
    @end
