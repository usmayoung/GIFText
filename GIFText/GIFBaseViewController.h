//
//  GIFBaseViewController.h
//  GIFTextView
//
//  Created by Eric Young on 1/30/16.
//  Copyright © 2016 Eric Young. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GIFEditTextView.h"

@interface GIFBaseViewController : UIViewController <GIFEditTextViewDelegate>
@property (nonatomic, strong) NSMutableArray *textFields;
@property (nonatomic, strong) GIFEditTextView *selectedTextView;




@end
