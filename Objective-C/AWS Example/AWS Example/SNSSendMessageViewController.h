//
//  SNSSendMessageViewController.h
//  AWS Example
//
//  Created by Justin Liu on 11/6/14.
//  Copyright (c) 2014 Crittercism. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AWSiOSSDKv2/SNS.h>

@interface SNSSendMessageViewController : UIViewController

@property (strong, nonatomic) AWSSNS *snsClient;

- (IBAction)subscribeByEmail:(id)sender;
- (IBAction)publishMessage:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *messageTextField;

@end
