//
//  GIFTextOptionsViewController.h
//  GIFTextView
//
//  Created by Eric Young on 1/30/16.
//  Copyright © 2016 Eric Young. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GIFBaseViewController.h"
#import "GIFTextViewController.h"
#import "GIFFontViewController.h"

@class GIFTextOptionsViewController;

@protocol GIFTextOptionsViewControllerDelegate
-(void)gifTextOptionsViewControllerDidFinishWithTextFields:(NSMutableArray*)textFields;
@end

@interface GIFTextOptionsViewController : GIFBaseViewController <GIFTextViewControllerDelegate, GIFFontViewControllerDelegate>

@property (nonatomic, weak) id<GIFTextOptionsViewControllerDelegate>delegate;

@end
