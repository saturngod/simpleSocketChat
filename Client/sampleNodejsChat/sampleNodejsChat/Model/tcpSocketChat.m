//
//  tcpSocketChat.m
//  sampleNodejsChat
//
//  Created by Htain Lin Shwe on 15/11/12.
//  Copyright (c) 2012 comquas. All rights reserved.
//

#import "tcpSocketChat.h"
#define HOST @"192.168.1.95"
#define PORT 5100

@interface tcpSocketChat()
@property(nonatomic,strong) GCDAsyncSocket* asyncSocket;
@end

@implementation tcpSocketChat
@synthesize delegate = _delegate;
@synthesize asyncSocket = _asyncSocket;
-(id)initWithDelegate:(id)delegateObject {
    self = [super init];
    if(self)
    {
        _delegate = delegateObject;
        _asyncSocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
        
        NSError* err;
        if([self.asyncSocket connectToHost:HOST onPort:PORT error:&err])
        {
            
        }
        else {
            NSLog(@"ERROR %@",[err description]);
        }
            
    }
    return self;
}

-(void)sendMessage:(NSString *)str
{
    [self.asyncSocket writeData:[str dataUsingEncoding:NSUTF8StringEncoding] withTimeout:-1 tag:0];
}

#pragma mark - AsyncDelegate
- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port {
    [self.asyncSocket readDataWithTimeout:-1 tag:0];
}

- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag {
    
    if([self.delegate respondsToSelector:@selector(receivedMessage:)])
    {
        NSString* str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        [self.delegate receivedMessage:str];
    }
    [self.asyncSocket readDataWithTimeout:-1 tag:0];
}
@end
