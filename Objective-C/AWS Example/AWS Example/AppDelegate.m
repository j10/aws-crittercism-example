//
//  AppDelegate.m
//  AWS Example
//
//  Created by Justin Liu on 11/6/14.
//  Copyright (c) 2014 Crittercism. All rights reserved.
//

#import "AppDelegate.h"
#import "Crittercism.h"
#import "Constants.h"
#import "AWSCore.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [Crittercism enableWithAppID:CRITTERCISM_APP_ID];
    [AWSLogger defaultLogger].logLevel = AWSLogLevelVerbose;
    
    return YES;
}

@end
