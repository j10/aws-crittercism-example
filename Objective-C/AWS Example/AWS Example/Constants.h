//
//  Constants.h
//  AWS Example
//
//  Created by Justin Liu on 11/6/14.
//  Copyright (c) 2014 Crittercism. All rights reserved.
//

/**
 * Crittercism Initialization
 *
 * If you'd like to test against your own developer account, create an app
 * and replace the app ID below with the new ID found on the app's settings
 * page.
 *
 * Also be aware that you will need to setup this example app to link
 * against the Crittercism library before it will build properly.
 *
 * Instructions can be found here:
 *
 * https://app.crittercism.com/developers/docs
 *
 */
#warning Replace XXXX with appropriate values
#define CRITTERCISM_APP_ID          @"XXXX"


/**
 * AWS Initialization
 *
 * If you'd like to test against your own developer account, create an app
 * and replace the app ID below with the new ID found on the app's settings
 * page.
 *
 * Instructions can be found here:
 *
 * http://aws.amazon.com/developers/getting-started/ios/
 *
 */
#warning Replace XXXX with appropriate values
#define AWS_ACCESS_KEY_ID           @"XXXX"
#define AWS_SECRET_KEY              @"XXXX"

// Constants for Cognito
# define AWS_ACCOUNT_ID             @"XXXX"
# define COGNITO_IDENTITY_POOL      @"XXXX"
# define UNAUTHENTICATED_ROLE       @"XXXX"
# define AUTHENTICATED_ROLE         @"XXXX"

// Constants for DynamoDB
#define DDB_TEST_TABLE_HASHKEY      @"demo-ddb-table-hash"
#define DDB_TEST_TABLE_NAME         @"demo-ddb-table-name"
#define DDB_TEST_TABLE_COL1         @"demo-title"
#define DDB_TEST_TABLE_COL2         @"demo-detail"

// Constants for SNS
#define SNS_TOPIC_NAME              @"demo-topic"
