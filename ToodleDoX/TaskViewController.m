//
//  TaskViewController.m
//  ToodleDoX
//
//  Created by Filip Kis on 12/9/4.
//  Copyright (c) 2012 Filip Kis. All rights reserved.
//

#import "TaskViewController.h"

@implementation TaskViewController

+(id)initWithTask:(NSMutableDictionary*)task session:(Session*) session{
    TaskViewController *c = [[TaskViewController alloc] initWithNibName:@"TaskView" bundle:nil];
    if(c){
        [c setTask:task];
        [c setSession:session];

    }
    return c;
}

-(void)awakeFromNib{
    [[self taskCheckBox] setTitle:[[self task] valueForKey:@"title"]];
    [[self view] setToolTip:[[self task] valueForKey:@"note"]];
    if([[self task] valueForKey:@"contextName"]){
        [[self contextText] setStringValue:[[self task] valueForKey:@"contextName"]];
    } else {
        [[self contextText] setStringValue:@""];
    }
    NSDate* date = [NSDate  dateWithTimeIntervalSince1970:[(NSString*)[[self task] valueForKey:@"duedate"] doubleValue]];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    [[self dateText] setStringValue:[dateFormat stringFromDate:date]];
}
- (IBAction)task_done:(id)sender {
    NSDate* now = [NSDate date];
    [[self task] setObject:[NSString stringWithFormat:@"%.0f",[now timeIntervalSince1970]] forKey:@"completed"];
    [[self session] edit_task:[self task]];
    [[[[self view] enclosingMenuItem] menu] cancelTracking];
}
- (IBAction)task_web:(id)sender {
    NSString* url = [NSString stringWithFormat: @"http://www.toodledo.com/tasks/index.php?#task_%@", [[self task] valueForKey:@"id"]];
    [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:url]];
}

@end
