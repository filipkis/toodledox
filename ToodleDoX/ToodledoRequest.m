//
//  ToodledoRequest.m
//  ToodleDoX
//
//  Created by Filip Kis on 12/8/31.
//  Copyright (c) 2012 Filip Kis. All rights reserved.
//

#import "ToodledoRequest.h"

@implementation ToodledoRequest 



-(void)request:(NSString *) url requestDelegate:(id)requestDelegate requestSelector:(SEL)requestSelector {
    delegate = requestDelegate;
	callback = requestSelector;
    NSURL *requesturl = [NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]];
    NSLog(@"%@",requesturl);
	NSMutableURLRequest *theRequest   = [[NSMutableURLRequest alloc] initWithURL:requesturl];
    NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
	
	if (theConnection) {
		// Create the NSMutableData that will hold
		// the received data
		// receivedData is declared as a method instance elsewhere
        receivedData=[NSMutableData data];
	} else {
		// inform the user that the download could not be made
	}
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    // this method is called when the server has determined that it
    // has enough information to create the NSURLResponse
	
    // it can be called multiple times, for example in the case of a
    // redirect, so each time we reset the data.
    // receivedData is declared as a method instance elsewhere
    [receivedData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	//NSLog([[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
	// append the new data to the receivedData
    // receivedData is declared as a method instance elsewhere
    [receivedData appendData:data];
}

- (void)connection:(NSURLConnection *)connection
  didFailWithError:(NSError *)error
{
	
    // inform the user
    NSLog(@"Connection failed! Error - %@ %@",
          [error localizedDescription],
          [[error userInfo] objectForKey:NSErrorFailingURLStringKey]);
	
	if(errorCallback) {
		[delegate performSelector:errorCallback withObject:error];
	}
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    // do something with the data
	
	if(delegate && callback) {
		if([delegate respondsToSelector:callback]) {
			[delegate performSelector:callback withObject:receivedData];
		} else {
			NSLog(@"No response from delegate");
		}
	}
}

@end
