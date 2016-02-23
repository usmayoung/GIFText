//
//  ViewController.h
//  GIFTextView
//
//  Created by Eric Young on 1/20/16.
//  Copyright © 2016 Eric Young. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GIFTextViewController.h"
#import "GIFTextOptionsViewController.h"

@interface ViewController : UIViewController <UITextFieldDelegate, GIFTextOptionsViewControllerDelegate>
- (IBAction)changedText:(id)sender;

- (IBAction)testAction:(id)sender;

@end

