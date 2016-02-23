//
//  GIFFontViewController.h
//  GIFTextView
//
//  Created by Eric Young on 2/1/16.
//  Copyright © 2016 Eric Young. All rights reserved.
//

#import "GIFBaseViewController.h"

@class GIFFontViewController;

@protocol GIFFontViewControllerDelegate
-(void)gifFontViewControllerDidFinishWithTextFields:(NSMutableArray*)textFields;
@end

@interface GIFFontViewController : GIFBaseViewController <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, weak) id<GIFFontViewControllerDelegate>delegate;

@end
