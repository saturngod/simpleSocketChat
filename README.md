TCP chat with iOS using nodejs tcp socket.

## Run server

Before running , you need to change IP address in **server/socket.js**.

Currently I am using 192.168.1.95 and port 5100. You can change at **server/socket.js**

	node server/socket.js
	

## Run Xcode

Before running , need to config at **tcpSocketChat.m**.

	#define HOST @"192.168.1.95"
	#define PORT 5100

## Usages Library


[https://github.com/robbiehanson/CocoaAsyncSocket](https://github.com/robbiehanson/CocoaAsyncSocket)

## Demo


[http://www.youtube.com/watch?v=rutDFYw7GFk&feature=youtu.be](http://www.youtube.com/watch?v=rutDFYw7GFk&feature=youtu.be)
