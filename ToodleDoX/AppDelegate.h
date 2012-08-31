//
//  AppDelegate.h
//  ToodleDoX
//
//  Created by Filip Kis on 12/8/31.
//  Copyright (c) 2012 Filip Kis. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class Task;

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;

- (IBAction)add:(id)sender;

- (IBAction)takeStringForName:(id)sender;
- (IBAction)takeStringForContext:(id)sender;

@property (strong) Task *task;



@end