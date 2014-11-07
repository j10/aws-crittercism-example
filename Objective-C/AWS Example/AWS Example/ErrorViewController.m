//
//  ErrorViewController.m
//  AWS Example
//
//  Created by Justin Liu on 11/6/14.
//  Copyright (c) 2014 Crittercism. All rights reserved.
//

#import "ErrorViewController.h"

@implementation ErrorViewController

- (IBAction)crashPressed:(id)sender {
    NSLog(@"Demo about to crash");
    [NSException raise:@"crash test" format:@"Crash button pressed"];
}

- (IBAction)leaveBreadcrumbPressed:(id)sender {
    NSLog(@"Demo leaving a breadcrumb");
    [Crittercism leaveBreadcrumb:@"breadcrumb left"];
}

- (IBAction)attachMetadataPressed:(id)sender {
    NSLog(@"Demo attaching metadata");
    [Crittercism setUsername:@"demo user"];
    [Crittercism setValue:@"42" forKey:@"Current Score"];
}

@end
