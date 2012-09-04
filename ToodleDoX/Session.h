//
//  Session.h
//  ToodleDoX
//
//  Created by Filip Kis on 12/8/31.
//  Copyright (c) 2012 Filip Kis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONKit/JSONKit.h"

@interface Session : NSObject{
    NSString *token;
    NSString *path;
    NSArray *_contexts;
    NSString *key;
    NSArray *_tasks;
    NSTimer *timer;
}

@property (assign) id owner;
@property (assign) NSString *username;
@property (assign) NSString *password;
@property (assign) NSString *userid;
@property (assign) NSString *appid;
@property (assign) NSString *apptoken;
@property (assign) NSString *sig;
@property (assign) NSDate *tokenDate;

+(NSString*)md5:(NSString*)text;

-(NSArray*)contexts;
-(void)get_contexts;
-(NSString*)contextById:(NSString*)cid;

-(void)add_task:(NSMutableDictionary*) values;
-(void)edit_task:(NSMutableDictionary*) values;

@end

