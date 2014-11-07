//
//  CognitoViewController.m
//  AWS Example
//
//  Created by Justin Liu on 11/6/14.
//  Copyright (c) 2014 Crittercism. All rights reserved.
//

#import "CognitoViewController.h"
#import "AWSCore.h"
#import "Cognito.h"
#import "Constants.h"

@interface CognitoViewController ()

@property (strong, nonatomic) IBOutlet UITextField *datasetField;

@end

@implementation CognitoViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Provide AWS Credentials
    AWSCognitoCredentialsProvider *credentialsProvider = [AWSCognitoCredentialsProvider
                                                          credentialsWithRegionType:AWSRegionUSEast1
                                                          accountId:AWS_ACCOUNT_ID
                                                          identityPoolId:COGNITO_IDENTITY_POOL
                                                          unauthRoleArn:UNAUTHENTICATED_ROLE
                                                          authRoleArn:AUTHENTICATED_ROLE];

    AWSServiceConfiguration *configuration = [AWSServiceConfiguration configurationWithRegion:AWSRegionUSEast1
                                                                          credentialsProvider:credentialsProvider];
    
    [AWSServiceManager defaultServiceManager].defaultServiceConfiguration = configuration;

    // Store and synchronize data
    AWSCognito *syncClient = [AWSCognito defaultCognito];
    AWSCognitoDataset *dataset = [syncClient openOrCreateDataset:@"testDataset"];
    [dataset setString:@"myValue" forKey:@"myKey"];
    [dataset synchronize];
    
    NSLog(@"Cognito datasets: %@", [syncClient listDatasets]);
    self.datasetField.text = @"testDataset";
}

@end
