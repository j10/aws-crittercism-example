//
//  DynamoDBReadTableViewController.m
//  AWS Example
//
//  Created by Justin Liu on 11/6/14.
//  Copyright (c) 2014 Crittercism. All rights reserved.
//

#import "DynamoDBReadTableViewController.h"
#import "Constants.h"
#import <Bolts/BFTask.h>
#import <Bolts/BFExecutor.h>

@implementation DynamoDBReadTableViewController

@synthesize items = _items;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Initialize the client
    AWSStaticCredentialsProvider *credentials = [AWSStaticCredentialsProvider credentialsWithAccessKey:AWS_ACCESS_KEY_ID
                                                                                             secretKey:AWS_SECRET_KEY];
    AWSServiceConfiguration *configuration = [AWSServiceConfiguration configurationWithRegion:AWSRegionUSWest2
                                                                          credentialsProvider:credentials];
    self.ddb = [[AWSDynamoDB alloc] initWithConfiguration:configuration];
    
    // Get the table
    AWSDynamoDBScanInput *si = [AWSDynamoDBScanInput new];
    si.tableName = DDB_TEST_TABLE_NAME;
    [[[self.ddb scan:si] continueWithSuccessBlock:^id(BFTask *task) {
        if (task.error) {
            NSLog(@"Error scanning table: %@", task.error);
            return nil;
        }

        AWSDynamoDBScanOutput *response = task.result;
        self.items = response.items;
        [self.tableView reloadData];
        
        return task;
    }] waitUntilFinished];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"DynamoDB Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    NSDictionary *item = [self.items objectAtIndex:indexPath.row];
    AWSDynamoDBAttributeValue *titleValue = [item valueForKey:DDB_TEST_TABLE_COL1];
    AWSDynamoDBAttributeValue *hashValue = [item valueForKey:DDB_TEST_TABLE_HASHKEY];

    cell.textLabel.text = titleValue.S ? titleValue.S : @"<blank>";
    cell.detailTextLabel.text = hashValue.N;
    return cell;
}

@end
