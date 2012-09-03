//
//  AppDelegate.m
//  ToodleDoX
//
//  Created by Filip Kis on 12/8/31.
//  Copyright (c) 2012 Filip Kis. All rights reserved.
//

#import "AppDelegate.h"
#import "Session.h"



@implementation AppDelegate

+(void)initialize {
    [self setupDefaults];
}

-(void)awakeFromNib{
    statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    [statusItem setMenu:statusMenu];
    [statusItem setImage:[NSImage imageNamed:@"tray_icon.png"]];
    [statusItem setAlternateImage:[NSImage imageNamed:@"tray_icon_invert.png"]];
    [statusItem setHighlightMode:YES];
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self
           selector:@selector(newTaskWindow:)
               name:@"OpenMainWindow"
             object:nil];
    [accountToolbarItem setEnabled:true];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    session = [[Session alloc] init];

    
    [NSEvent addGlobalMonitorForEventsMatchingMask:NSKeyDownMask
                                           handler:^(NSEvent * event){
                                               int flags = [event modifierFlags];
                                               int altDown = flags & NSAlternateKeyMask;
                                               if (([event keyCode] == 7) && altDown) {
                                                   [[NSNotificationCenter defaultCenter] postNotificationName:@"OpenMainWindow" object:nil];
                                               };
                                               
                                           }];
    
}


- (IBAction)add:(id)sender {
}

- (IBAction)newTaskWindow:(id)sender {
    [NSApp activateIgnoringOtherApps:YES];
    controller = [[NewTaskWindowController alloc] initWithWindowNibName:@"NewTaskWindow"];
    [controller setSession:session];
    [controller showWindow:self];


}

+ (void)setupDefaults
{
    NSString *userDefaultsValuesPath;
    NSDictionary *userDefaultsValuesDict;
    
    // load the default values for the user defaults
    userDefaultsValuesPath=[[NSBundle mainBundle] pathForResource:@"UserDefaults"
                                                           ofType:@"plist"];
    userDefaultsValuesDict=[NSDictionary dictionaryWithContentsOfFile:userDefaultsValuesPath];
    
    // set them in the standard user defaults
    [[NSUserDefaults standardUserDefaults] registerDefaults:userDefaultsValuesDict];
}

- (IBAction)close:(id)sender {
    [NSApp terminate:nil];
}

- (IBAction)showAllWindows:(id)sender {
    NSArray* windows = [NSApp windows];
    [NSApp activateIgnoringOtherApps:YES];
    for (NSWindow *win in windows) {
        NSLog(@"%@",[win title]);
        [win makeKeyAndOrderFront:nil];
    }
}


@end
