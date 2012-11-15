//
//  tcpSocketChat.h
//  sampleNodejsChat
//
//  Created by Htain Lin Shwe on 15/11/12.
//  Copyright (c) 2012 comquas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GCDAsyncSocket.h"

@protocol tcpSocketChatDelegate <NSObject>

@required
-(void)receivedMessage:(NSString*)data;
@end

@interface tcpSocketChat : NSObject <GCDAsyncSocketDelegate>
@property (nonatomic,assign) id<tcpSocketChatDelegate> delegate;

-(id)initWithDelegate:(id)delegateObject;

/**
 Send the message to TCP Chat Server
 */
-(void)sendMessage:(NSString*)str;


@end
