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
}

@property (assign) NSString *username;
@property (assign) NSString *password;
@property (assign) NSString *userid;
@property (assign) NSString *appid;
@property (assign) NSString *apptoken;
@property (assign) NSString *sig;
//@property (assign) NSString *token;
@property (assign) NSDate *tokenDate;



-(NSString*) token;

+(NSString*)md5:(NSString*)text;



-(void)create_signature;

-(void)token_callback:(NSData *) data;

-(void)get_contexts;

-(NSArray*)contexts;

-(void)add_task:(NSMutableDictionary*) values;

@end

