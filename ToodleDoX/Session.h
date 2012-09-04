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
    NSMutableArray *_tasks;
    NSTimer *timer;
}

@property (retain) id owner;
@property (retain) NSString *username;
@property (retain) NSString *password;
@property (retain) NSString *userid;
@property (retain) NSString *appid;
@property (retain) NSString *apptoken;
@property (retain) NSString *sig;
@property (retain) NSDate *tokenDate;

+(NSString*)md5:(NSString*)text;

-(NSArray*)contexts;
-(void)get_contexts;
-(NSString*)contextById:(NSString*)cid;

-(void)add_task:(NSMutableDictionary*) values;
-(void)edit_task:(NSMutableDictionary*) values;

@end

