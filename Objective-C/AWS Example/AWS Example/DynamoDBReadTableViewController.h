//
//  DynamoDBReadTableViewController.h
//  AWS Example
//
//  Created by Justin Liu on 11/6/14.
//  Copyright (c) 2014 Crittercism. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AWSiOSSDKv2/AWSDynamoDB.h>

@interface DynamoDBReadTableViewController : UITableViewController

@property (strong, nonatomic) AWSDynamoDB *ddb;
@property (strong, nonatomic) NSArray *items;

@end
