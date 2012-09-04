//
//  TaskViewController.h
//  ToodleDoX
//
//  Created by Filip Kis on 12/9/4.
//  Copyright (c) 2012 Filip Kis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "session.h"

@interface TaskViewController : NSViewController{

}

@property (assign) Session* session;
@property (retain) NSMutableDictionary *task;
@property (assign) IBOutlet NSButton *taskCheckBox;
@property (assign) IBOutlet NSTextField *contextText;
@property (assign) IBOutlet NSTextField *dateText;

+(id)initWithTask:(NSMutableDictionary*)task session:(Session*) session;

@end
