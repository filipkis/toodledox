//
//  Session.m
//  ToodleDoX
//
//  Created by Filip Kis on 12/8/31.
//  Copyright (c) 2012 Filip Kis. All rights reserved.
//

#import "Session.h"
#import <CommonCrypto/CommonDigest.h>
#import "ToodledoRequest.h"

@implementation Session

- (id)init
{
    self = [super init];
    if (self) {
        [self setUserid:[[NSUserDefaults standardUserDefaults]stringForKey:@"userid"]];
        token = [[NSUserDefaults standardUserDefaults]stringForKey:@"token"];
        [self setTokenDate:(NSDate *)[[NSUserDefaults standardUserDefaults]objectForKey:@"tokenDate"]];
        [self setPassword:[[NSUserDefaults standardUserDefaults]stringForKey:@"password"]];
        NSLog(@"Initial token: %@ token date: %@",token,[self tokenDate]);
        path = @"http://api.toodledo.com/2/";
        [self setAppid:@"toodledoxapp"];
        [self setApptoken:@"api5040f03769d18"];
        [self create_signature];
        NSLog(@"%@", [self sig]);
        [self token];
        NSLog(@"Info pass:%@ atoken:%@ stoken:%@",
        [self password],[self apptoken],token);
        key=[Session md5:[NSString stringWithFormat:@"%@%@%@",
                                [[self password] lowercaseString],[self apptoken],token]];
        [self get_contexts];
    }
    return self;
}


-(void)create_signature {
    [self setSig:[Session md5:[NSString stringWithFormat:@"%@%@",[self userid],[self apptoken]]]];
}

+(NSString*)md5:(NSString*)text{
    const char *cStr = [text UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, strlen(cStr), result);
    return [NSString stringWithFormat: @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X", result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7], result[8], result[9], result[10], result[11], result[12], result[13], result[14], result[15]];
}

-(NSString*) token {
    if(token){
        double time_interval = 3*60*60;
        NSLog(@"%f",fabs([[self tokenDate] timeIntervalSinceNow]));
        if(time_interval>fabs([[self tokenDate] timeIntervalSinceNow])){
            return token;
        }
    }
    NSString *url = [NSString stringWithFormat:@"%@account/token.php?userid=%@;appid=%@;sig=%@",path,[self userid], [self appid], [self sig]];
    ToodledoRequest* request = [[ToodledoRequest alloc] init];
    [request request:url requestDelegate:self requestSelector:@selector(token_callback:)];
    return nil;
    

}

-(void)token_callback:(NSData *) data {
    [self setTokenDate : [NSDate date]];
    NSString *response = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
    NSLog(@"At %@ recieved token: %@ ",[self tokenDate],response);
    NSError *e = nil;
    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData: data options: NSJSONReadingMutableContainers error: &e];
    
    if (!jsonArray) {
        NSLog(@"Error parsing JSON: %@", e);
    } else {
        for(NSDictionary *item in jsonArray) {
            token = [jsonArray valueForKey:@"token"];
            [[NSUserDefaults standardUserDefaults] setValue:token forKey:@"token"];
                        [[NSUserDefaults standardUserDefaults] setObject:[self tokenDate] forKey:@"tokenDate"];
            key = [Session md5:[NSString stringWithFormat:@"%@%@%@",
                                    [self password],[self apptoken],token]];
        }
    }
    NSLog(@"Token: %@ token date: %@",token,[self tokenDate]);
}

-(void)context_callback:(NSData *) data {
    NSError *e = nil;
    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData: data options: NSJSONReadingMutableContainers error: &e];
    
    if (!jsonArray) {
        NSLog(@"Error parsing JSON: %@", e);
    } else {
        _contexts = jsonArray;
    }
}

-(void)get_contexts {
    NSString *url = [NSString stringWithFormat:@"%@contexts/get.php?key=%@",path,key];
    ToodledoRequest* request = [[ToodledoRequest alloc] init];
    [request request:url requestDelegate:self requestSelector:@selector(context_callback:)];
}

-(NSArray*)contexts {
    return _contexts;
}

-(void)add_task:(NSMutableDictionary*) values{
    NSString *url = [NSString stringWithFormat:@"%@tasks/add.php?key=%@;tasks=%@",path,key,[values JSONString]];
    NSLog(@"%@",url);
    ToodledoRequest* request = [[ToodledoRequest alloc] init];
    [request request:url requestDelegate:self requestSelector:nil];
}
@end


