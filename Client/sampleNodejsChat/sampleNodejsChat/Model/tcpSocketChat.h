//
//  tcpSocketChat.h
//  sampleNodejsChat
//
//  Created by saturngod
//

#import <Foundation/Foundation.h>
#import "GCDAsyncSocket.h"

@protocol tcpSocketChatDelegate <NSObject>

@required
-(void)receivedMessage:(NSString*)data;
@end

@interface tcpSocketChat : NSObject <GCDAsyncSocketDelegate>
@property (nonatomic,assign) id<tcpSocketChatDelegate> delegate;

/**
 Init Object
 !param host Connection HOST Name
 !param port Connection Port Number
 */

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
