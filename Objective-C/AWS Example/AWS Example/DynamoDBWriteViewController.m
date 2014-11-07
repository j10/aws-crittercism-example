//
//  DynamoDBWriteViewController.m
//  AWS Example
//
//  Created by Justin Liu on 11/6/14.
//  Copyright (c) 2014 Crittercism. All rights reserved.
//

#import "DynamoDBWriteViewController.h"
#import "Constants.h"
#import <Bolts/BFTask.h>

@implementation DynamoDBWriteViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Initialize the client
    AWSStaticCredentialsProvider *credentials = [AWSStaticCredentialsProvider credentialsWithAccessKey:AWS_ACCESS_KEY_ID
                                                                                             secretKey:AWS_SECRET_KEY];
    AWSServiceConfiguration *configuration = [AWSServiceConfiguration configurationWithRegion:AWSRegionUSWest2
                                                                          credentialsProvider:credentials];
    self.ddb = [[AWSDynamoDB alloc] initWithConfiguration:configuration];
    
    // Define a table
    AWSDynamoDBProvisionedThroughput *provisionedThroughput = [AWSDynamoDBProvisionedThroughput new];
    provisionedThroughput.readCapacityUnits  = [NSNumber numberWithInt:10];
    provisionedThroughput.writeCapacityUnits = [NSNumber numberWithInt:5];

    AWSDynamoDBKeySchemaElement *keySchemaElement = [AWSDynamoDBKeySchemaElement new];
    keySchemaElement.attributeName = DDB_TEST_TABLE_HASHKEY;
    keySchemaElement.keyType = AWSDynamoDBKeyTypeHash;
    NSArray *keySchema = [[NSArray alloc] initWithObjects:keySchemaElement, nil];
    
    AWSDynamoDBAttributeDefinition *attributeDefinition = [AWSDynamoDBAttributeDefinition new];
    attributeDefinition.attributeName = DDB_TEST_TABLE_HASHKEY;
    attributeDefinition.attributeType = AWSDynamoDBScalarAttributeTypeN;
    NSArray *attributeDefinitions = [[NSArray alloc] initWithObjects:attributeDefinition, nil];
    
    AWSDynamoDBCreateTableInput *request = [AWSDynamoDBCreateTableInput new];
    request.tableName = DDB_TEST_TABLE_NAME;
    request.provisionedThroughput = provisionedThroughput;
    request.keySchema = keySchema;
    request.attributeDefinitions = attributeDefinitions;
    
    // Create a table
    [[self.ddb createTable:request] continueWithBlock:^id(BFTask *task) {
        if (task.error) {
            NSLog(@"Error creating table: %@", task.error);
            return nil;
        }
        
        NSLog(@"Created table: %@", task.result);
        return task;
    }];
}


#pragma mark - DynamoDB client actions

- (IBAction)insert:(id)sender
{
    AWSDynamoDBAttributeValue *hashValue = [AWSDynamoDBAttributeValue new];
    hashValue.N = (id)[NSString stringWithFormat:@"%ld", (long)[[NSDate date] timeIntervalSince1970]];
    
    AWSDynamoDBAttributeValue *title = [AWSDynamoDBAttributeValue new];
    title.S = (id)self.titleTextField.text;
    
    AWSDynamoDBAttributeValue *detail = [AWSDynamoDBAttributeValue new];
    detail.S = hashValue.N;
    
    // Insert the record
    AWSDynamoDBPutItemInput *request = [AWSDynamoDBPutItemInput new];
    request.tableName = DDB_TEST_TABLE_NAME;
    request.item = @{
                     DDB_TEST_TABLE_HASHKEY : hashValue,
                     DDB_TEST_TABLE_COL1 : title,
                     DDB_TEST_TABLE_COL2 : detail,
                     };
    
    [[self.ddb putItem:request] continueWithBlock:^id(BFTask *task) {
        if (task.error) {
            NSLog(@"Error inserting item: %@", task.error);
            return nil;
        }
        
        NSLog(@"Inserted item: %@", task.result);
        return task;
    }];
}


- (IBAction)deleteTable:(id)sender
{
    AWSDynamoDBDeleteTableInput *request = [AWSDynamoDBDeleteTableInput new];
    request.tableName = DDB_TEST_TABLE_NAME;
    
    [[self.ddb deleteTable:request] continueWithBlock:^id(BFTask *task) {
        if (task.error) {
            NSLog(@"Error deleting table: %@", task.error);
            return nil;
        }
        
        NSLog(@"Deleted table: %@", task.result);
        return task;
    }];
}

@end
