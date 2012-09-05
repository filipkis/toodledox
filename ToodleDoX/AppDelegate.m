//
//  AppDelegate.m
//  ToodleDoX
//
//  Created by Filip Kis on 12/8/31.
//  Copyright (c) 2012 Filip Kis. All rights reserved.
//

#import "AppDelegate.h"
#import "Session.h"
#import "TaskViewController.h"
#import <Carbon/Carbon.h>


@implementation AppDelegate

int menu_position = 4;
int menu_items_initial_count;

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
    menu_items_initial_count =  statusMenu.itemArray.count;
    
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    session = [[Session alloc] init];
    [session setOwner:self];
    
    EventHotKeyRef gMyHotKeyRef;
    EventHotKeyID gMyHotKeyID;
    EventTypeSpec eventType;
    eventType.eventClass=kEventClassKeyboard;
    eventType.eventKind=kEventHotKeyPressed;
    
    InstallApplicationEventHandler(&MyHotKeyHandler,1,&eventType,(void *)CFBridgingRetain(self),NULL);

    gMyHotKeyID.signature='htk1';
    gMyHotKeyID.id=1;
    
    RegisterEventHotKey(17, cmdKey+controlKey, gMyHotKeyID,
                        GetApplicationEventTarget(), 0, &gMyHotKeyRef);
    
    
}

OSStatus MyHotKeyHandler(EventHandlerCallRef nextHandler,EventRef theEvent,
                         void *userData)
{
    AppDelegate* myself = (__bridge AppDelegate*)userData;
    [myself newTaskWindow:nil];
    return noErr;
}

- (void)tasks_updated:(NSMutableArray*) tasks {
    utask = 0;
    //NSMutableArray* sorted = [NSMutableArray arrayWithArray:tasks];
    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"duedate"  ascending:NO];
    NSArray * sorted =[tasks sortedArrayUsingDescriptors:[NSArray arrayWithObjects:descriptor,nil]];
    
    while ([statusMenu numberOfItems]>menu_items_initial_count){
        [statusMenu removeItemAtIndex:menu_position];
    }
    
    
    taskViewControllers = [NSMutableArray array];
    for(NSDictionary* task in sorted){
        NSMutableDictionary* taskc = [NSMutableDictionary dictionaryWithDictionary:task];
        NSString* contextName = [session contextById:[task objectForKey:@"context"]];
        if(contextName){
            [taskc setObject:contextName forKey:@"contextName"];
        }
        double tidate =[(NSString*)[task valueForKey:@"duedate"] doubleValue];
        if(tidate>0) {
            NSDate* tdate = [NSDate  dateWithTimeIntervalSince1970:tidate];
            NSDate* now = [NSDate date];
            NSDate* tdate_day = [self dateWithOnlyDay:tdate];
            NSDate* now_day =[self dateWithOnlyDay:now];
            if([tdate timeIntervalSinceDate:now]<0 || [tdate_day timeIntervalSinceDate:now_day] == 0){
                utask++;
                TaskViewController* taskViewC = [TaskViewController initWithTask:taskc session:session ];
                NSMenuItem* newItem;
                newItem = [[NSMenuItem alloc]init];
                [newItem setView: [taskViewC view]];
                [newItem setTarget:self];
                [statusMenu insertItem:newItem atIndex:menu_position];
                [taskViewControllers addObject:taskViewC ];
            } 
        }
    }
    if(utask > 0) {
        [statusItem setTitle:[NSString stringWithFormat:@"%i",utask]];
     } else {
        [statusItem setTitle:nil];
     }
}

-(NSDate*)dateWithOnlyDay:(NSDate*)date {
    unsigned int flags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    NSCalendar* calendar = [NSCalendar currentCalendar];
    
    NSDateComponents* components = [calendar components:flags fromDate:date];
    
    return [calendar dateFromComponents:components];
}

- (void)test {
    NSLog(@"Bla");
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
        if(![[win title] isEqualToString:@"Preferences"]){
            [win makeKeyAndOrderFront:nil];
        }
    }
}


@end
