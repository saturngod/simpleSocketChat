//
//  ViewController.m
//  sampleNodejsChat
//
//  Created by Htain Lin Shwe on 15/11/12.
//  Copyright (c) 2012 comquas. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic,strong) tcpSocketChat* chatSocket;
@end

@implementation ViewController
@synthesize chatBox = _chatBox;
@synthesize logView = _logView;
@synthesize chatSocket = _chatSocket;

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    
    self.chatSocket = nil;
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    _chatSocket = [[tcpSocketChat alloc] initWithDelegate:self AndSocketHost:@"192.168.1.49" AndPort:5100];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)disconnect:(id)sender {
    if([_chatSocket isConnected]) {
        [_chatSocket disconnect];

        self.logView.text = [self.logView.text stringByAppendingFormat:@"ME >> left the chat. Bye Bye!\n"];
        [self.chatBox resignFirstResponder];
        
    }
}

-(void)checkConnection
{
    if([_chatSocket isDisconnected])
    {
        [_chatSocket reconnect];
    }
}

#pragma mark - Keyboard Delegate
-(void)keyboardWillShow:(NSNotification*)noti
{
    NSDictionary *userInfo = [noti userInfo];
    
    // Get the origin of the keyboard when it's displayed.
    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    // Get the top of the keyboard as the y coordinate of its origin in self's view's coordinate system. The bottom of the text view's frame should align with the top of the keyboard's final position.
    CGRect keyboardRect = [aValue CGRectValue];
    keyboardRect = [self.view convertRect:keyboardRect fromView:nil];
    
    
    //if disconnect , reconnect again
    [self checkConnection];
    
    [UIView beginAnimations:@"keyboardAnimation" context:nil];
    [UIView setAnimationDuration:0.4];
    CGRect frame = self.chatBox.frame;
    frame.origin.y = frame.origin.y - keyboardRect.size.height;
    self.chatBox.frame = frame;
    
    frame = self.logView.frame;
    frame.size.height = frame.size.height - keyboardRect.size.height;
    self.logView.frame = frame;
    
    frame = self.btnDisconnect.frame;
    frame.origin.y = self.chatBox.frame.origin.y;
    self.btnDisconnect.frame = frame;
    [UIView commitAnimations];
}

-(void)keyboardWillHide:(NSNotification*)noti
{
    NSDictionary *userInfo = [noti userInfo];
    
    // Get the origin of the keyboard when it's displayed.
    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    // Get the top of the keyboard as the y coordinate of its origin in self's view's coordinate system. The bottom of the text view's frame should align with the top of the keyboard's final position.
    CGRect keyboardRect = [aValue CGRectValue];
    keyboardRect = [self.view convertRect:keyboardRect fromView:nil];
    
    [UIView beginAnimations:@"keyboardAnimation" context:nil];
    [UIView setAnimationDuration:0.4];
    CGRect frame = self.chatBox.frame;
    frame.origin.y = frame.origin.y + keyboardRect.size.height;
    self.chatBox.frame = frame;
    
    frame = self.logView.frame;
    frame.size.height = frame.size.height + keyboardRect.size.height;
    self.logView.frame = frame;
    
    frame = self.btnDisconnect.frame;
    frame.origin.y = self.chatBox.frame.origin.y;
    self.btnDisconnect.frame = frame;
    [UIView commitAnimations];
}



#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.chatSocket sendMessage:textField.text];
    
    self.logView.text = [self.logView.text stringByAppendingFormat:@"ME >> %@\n",textField.text];
    
    textField.text = @"";
    
    [self.logView scrollRangeToVisible:NSMakeRange([self.logView.text length], 0)];
    return YES;
}

#pragma mark - tcpSocketDelegate
-(void)receivedMessage:(NSString *)data
{
    self.logView.text = [self.logView.text stringByAppendingFormat:@"%@",data];
     [self.logView scrollRangeToVisible:NSMakeRange([self.logView.text length], 0)];
}
@end
