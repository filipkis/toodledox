//
//  AppDelegate.h
//  ToodleDoX
//
//  Created by Filip Kis on 12/8/31.
//  Copyright (c) 2012 Filip Kis. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "NewTaskWindowController.h"

@class Task;

@interface AppDelegate : NSObject <NSApplicationDelegate> {
    IBOutlet NSMenu *statusMenu;
    NSStatusItem * statusItem;
    NewTaskWindowController *controller;
    Session *session;
    IBOutlet NSToolbarItem *accountToolbarItem;
    int utask;
    NSMutableArray* taskViewControllers;
    
}

//@property (assign) NSInteger* utask;
@property (assign) IBOutlet NSWindow *window;

- (IBAction)newTaskWindow:(id)sender;

@property (strong) Task *task;



@end
