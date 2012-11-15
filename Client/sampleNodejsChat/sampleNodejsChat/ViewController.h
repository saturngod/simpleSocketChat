//
//  ViewController.h
//  sampleNodejsChat
//
//  Created by Htain Lin Shwe on 15/11/12.
//  Copyright (c) 2012 comquas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "tcpSocketChat.h"
@interface ViewController : UIViewController <tcpSocketChatDelegate , UITextFieldDelegate>
@property (nonatomic,assign) IBOutlet UITextView* logView;
@property (nonatomic,assign) IBOutlet UITextField* chatBox;
@end
