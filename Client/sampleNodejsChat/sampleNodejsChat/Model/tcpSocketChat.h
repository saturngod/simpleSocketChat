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

-(id)initWithDelegate:(id)delegateObject AndSocketHost:(NSString*)host AndPort:(NSInteger)port;

/**
 Send the message to TCP Chat Server
 */
-(void)sendMessage:(NSString*)str;

/**
 Disconnect the current status
 */
-(void)disconnect;
-(void)reconnect;

/**
 Diagnostics
 */
- (BOOL)isDisconnected;
- (BOOL)isConnected;
@end
