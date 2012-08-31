//
//  Session.h
//  ToodleDoX
//
//  Created by Filip Kis on 12/8/31.
//  Copyright (c) 2012 Filip Kis. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Session : NSObject

@property (assign) NSString *username;
@property (assign) NSString *password;
@property (assign) NSString *userid;
@property (assign) NSString *appid;
@property (assign) NSString *sig;
@property (assign) NSString *token;

-(void)get_signature;
-(void)


@end
