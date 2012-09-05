//
//  NewTaskWindowController.m
//  ToodleDoX
//
//  Created by Filip Kis on 12/9/3.
//  Copyright (c) 2012 Filip Kis. All rights reserved.
//

#import "NewTaskWindowController.h"

@implementation NewTaskWindowController

-(void)awakeFromNib
{
    self.populate.content = session.contexts;
    [[self startDatePicker] setDateValue:[NSDate date]];
}

-(void) setSession:(Session *)s {
    session = s;
}

- (IBAction)add_task:(id)sender {
    
    NSString *title = [self.nameBox.stringValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    
    if(title.length == 0) {
        NSAlert *alert = [[NSAlert alloc] init];
        [alert addButtonWithTitle:@"OK"];
        [alert setMessageText:@"Missing task title"];
        [alert setInformativeText:@"The task must have at least a title"];
        [alert setAlertStyle:NSWarningAlertStyle];
        [alert runModal];
    } else {
        NSMutableDictionary* values = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                       self.nameBox.stringValue, @"title",
                                       nil];
        if([[self contextBox] indexOfSelectedItem]>=0) {
            NSArray* context = [[session contexts] objectAtIndex: [[self contextBox] indexOfSelectedItem]];
            [values setObject:[context valueForKeyPath:@"id"] forKey:@"context"];
        }
        
        if([[self startDateCheck] state] == NSOnState) {
            NSDate *startDate = [[self startDatePicker] dateValue];
            [values setObject:[NSString stringWithFormat:@"%.0f",[startDate timeIntervalSince1970]]
                       forKey:@"duedate"];
            
        }
        NSString *description = [self.descriptionBox.stringValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if(description.length >0) {
            [values setObject:description forKey:@"note"];
        }
        [session add_task:values];
        [self close];

    }
}

- (IBAction)checkDate:(id)sender {
    if([[self startDateCheck] state] == NSOffState) {
        [[self startDatePicker] setEnabled:FALSE];
    } else {
        [[self startDatePicker] setEnabled:true];
    }
}


@end
