//
//  NewTaskWindowController.h
//  ToodleDoX
//
//  Created by Filip Kis on 12/9/3.
//  Copyright (c) 2012 Filip Kis. All rights reserved.
//
#import <Cocoa/Cocoa.h>
#import <Foundation/Foundation.h>
#import "Session.h"

@interface NewTaskWindowController : NSWindowController {
        Session *session;
}

@property (assign) IBOutlet NSComboBox *contextBox;
@property (assign) IBOutlet NSTextField *nameBox;
@property (assign) IBOutlet NSArrayController *populate;
@property (assign) IBOutlet NSButton *startDateCheck;
@property (assign) IBOutlet NSDatePicker *startDatePicker;
@property (assign) IBOutlet NSTextField *descriptionBox;


-(void) setSession:(Session*) s;

@end
