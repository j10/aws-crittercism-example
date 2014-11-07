//
//  ErrorViewController.h
//  AWS Example
//
//  Created by Justin Liu on 11/6/14.
//  Copyright (c) 2014 Crittercism. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Crittercism.h"

@interface ErrorViewController : UIViewController <CrittercismDelegate>

- (IBAction)crashPressed:(id)sender;
- (IBAction)leaveBreadcrumbPressed:(id)sender;
- (IBAction)attachMetadataPressed:(id)sender;

@end
