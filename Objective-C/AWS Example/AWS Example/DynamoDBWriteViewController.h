//
//  DynamoDBWriteViewController.h
//  AWS Example
//
//  Created by Justin Liu on 11/6/14.
//  Copyright (c) 2014 Crittercism. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AWSiOSSDKv2/AWSDynamoDB.h>

@interface DynamoDBWriteViewController : UIViewController

@property (strong, nonatomic) AWSDynamoDB *ddb;

- (IBAction)insert:(id)sender;
- (IBAction)deleteTable:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *titleTextField;

@end
