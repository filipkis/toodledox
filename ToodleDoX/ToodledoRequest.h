//
//  ToodledoRequest.h
//  ToodleDoX
//
//  Created by Filip Kis on 12/8/31.
//  Copyright (c) 2012 Filip Kis. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ToodledoRequest : NSObject {
    NSMutableData *receivedData;
    id delegate;
    SEL callback;
    SEL errorCallback;
}

-(void)request:(NSString *) url requestDelegate:(id)requestDelegate requestSelector:(SEL)requestSelector;

@end
