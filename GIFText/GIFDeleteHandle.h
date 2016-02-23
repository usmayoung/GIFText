//
//  GIFDeleteHandle.h
//  GIFTextView
//
//  Created by Eric Young on 1/24/16.
//  Copyright © 2016 Eric Young. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GIFDeleteHandle;

@protocol GIFDeleteHandleDelegate <NSObject>
-(void)didDelete;
@end

@interface GIFDeleteHandle : UIView

@property (weak, nonatomic) id<GIFDeleteHandleDelegate>delegate;

@end
