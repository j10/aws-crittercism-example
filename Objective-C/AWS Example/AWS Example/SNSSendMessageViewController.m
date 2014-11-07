//
//  SNSSendMessageViewController.m
//  AWS Example
//
//  Created by Justin Liu on 11/6/14.
//  Copyright (c) 2014 Crittercism. All rights reserved.
//

#import "SNSSendMessageViewController.h"
#import "Constants.h"


@interface SNSSendMessageViewController ()

@property (nonatomic, strong) NSString *topicARN;

@end


@implementation SNSSendMessageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Initialize the SNS Client
    AWSStaticCredentialsProvider *credentials = [AWSStaticCredentialsProvider credentialsWithAccessKey:AWS_ACCESS_KEY_ID
                                                                                             secretKey:AWS_SECRET_KEY];
    AWSServiceConfiguration *configuration = [AWSServiceConfiguration configurationWithRegion:AWSRegionUSWest2
                                                                          credentialsProvider:credentials];
    self.snsClient = [[AWSSNS alloc] initWithConfiguration:configuration];
    
    // Create a topic
    AWSSNSCreateTopicInput *ctr = [[AWSSNSCreateTopicInput alloc] init];
    ctr.name = SNS_TOPIC_NAME;
    [[self.snsClient createTopic:ctr] continueWithBlock:^id(BFTask *task) {
        if (task.error) {
            NSLog(@"Error creating topic: %@", task.error);
            return nil;
        }
        AWSSNSCreateTopicResponse *response = task.result;
        self.topicARN = response.topicArn;
        
        NSLog(@"Created topic: %@", task.result);
        return task;
    }];
    
    // Set topic attributes
    AWSSNSSetTopicAttributesInput *st = [[AWSSNSSetTopicAttributesInput alloc] init];
    st.topicArn = self.topicARN;
    st.attributeName = @"DisplayName";
    st.attributeValue = SNS_TOPIC_NAME;
    [[self.snsClient setTopicAttributes:st] continueWithBlock:^id(BFTask *task) {
        if (task.error) {
            NSLog(@"Error setting topic attributes: %@", task.error);
            return nil;
        }
        
        NSLog(@"Set topic attributes: %@", task.result);
        return task;
    }];
}

#pragma mark - SNS Client actions

- (IBAction)subscribeByEmail:(id)sender
{
    AWSSNSSubscribeInput *sr = [[AWSSNSSubscribeInput alloc] init];
    sr.topicArn = self.topicARN;
    sr.protocol = @"email";
    sr.endpoint = self.emailTextField.text;
    
    [[self.snsClient subscribe:sr] continueWithBlock:^id(BFTask *task) {
        if (task.error) {
            NSLog(@"Error subscribing by email: %@", task.error);
            return nil;
        }
        
        NSLog(@"Subscribed: %@", task.result);
        return task;
    }];
}

- (IBAction)publishMessage:(id)sender
{
    AWSSNSPublishInput *pr = [[AWSSNSPublishInput alloc] init];
    pr.topicArn = self.topicARN;
    pr.message = self.messageTextField.text;
    
    [[self.snsClient publish:pr] continueWithBlock:^id(BFTask *task) {
        if (task.error) {
            NSLog(@"Error publishing message: %@", task.error);
            return nil;
        }
        
        NSLog(@"Published: %@", task.result);
        return task;
    }];
}

@end
