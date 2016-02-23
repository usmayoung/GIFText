//
//  GIFTextViewController.h
//  GIFTextView
//
//  Created by Eric Young on 1/29/16.
//  Copyright © 2016 Eric Young. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GIFBaseViewController.h"
#import "GIFEditTextView.h"

@class GIFTextViewController;

@protocol GIFTextViewControllerDelegate
-(void)gifTextViewControllerDidFinishWithTextFields:(NSMutableArray*)textFields;
@end

@interface GIFTextViewController : GIFBaseViewController

@property (nonatomic, weak) id<GIFTextViewControllerDelegate>delegate;

@end
