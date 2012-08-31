//
//  AppDelegate.m
//  ToodleDoX
//
//  Created by Filip Kis on 12/8/31.
//  Copyright (c) 2012 Filip Kis. All rights reserved.
//

#import "AppDelegate.h"
#import "Task.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    Task *aTask = [[Task alloc] init];
    [self setTask:aTask];
}


- (IBAction)add:(id)sender {
}

- (IBAction)takeStringForName:(id)sender {
    NSString *newValue = [sender stringValue];
    
    [self.task setName:newValue];
    
}

- (IBAction)takeStringForContext:(id)sender {
}
@end
