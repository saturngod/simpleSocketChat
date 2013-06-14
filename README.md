TCP chat with iOS using nodejs tcp socket.

## Run server

Before running , you need to change IP address in **server/socket.js**.

Currently I am using 192.168.1.95 and port 5100. You can change at **server/socket.js**

	node server/socket.js
	
## How to use

Allocate the socket server with HOST and Port

	 _chatSocket = [[tcpSocketChat alloc] initWithDelegate:self AndSocketHost:@"192.168.1.49" AndPort:5100];
	 
Send data

	[self.chatSocket sendMessage:textField.text];

Receive Data Delegate

	-(void)receivedMessage:(NSString *)data
	{
    	self.logView.text = [self.logView.text stringByAppendingFormat:@"%@",data];
    	[self.logView scrollRangeToVisible:NSMakeRange([self.logView.text length], 0)];
	}

Disconnect

	if([_chatSocket isConnected]) {
		[_chatSocket disconnect];
	}

Reconnect

	if([_chatSocket isDisconnected])
	{
		[_chatSocket reconnect];
	}

## Socket Server Code From

[https://gist.github.com/707146](https://gist.github.com/707146)

## Usages Library

[https://github.com/robbiehanson/CocoaAsyncSocket](https://github.com/robbiehanson/CocoaAsyncSocket)

## Demo

[http://www.youtube.com/watch?v=rutDFYw7GFk&feature=youtu.be](http://www.youtube.com/watch?v=rutDFYw7GFk&feature=youtu.be)
