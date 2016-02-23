//
//  GIFAnchorHandle.h
//  GIFTextView
//
//  Created by Eric Young on 1/20/16.
//  Copyright © 2016 Eric Young. All rights reserved.
//

#import <UIKit/UIKit.h>


@class GIFAnchorHandle;

@protocol GIFAnchorHandleDelegate <NSObject>
-(void)didChangeScaleToPoint:(CGPoint)point;
-(void)didEndChange;
@end

@interface GIFAnchorHandle : UIView

@property (assign, nonatomic) CGPoint movePoint;
@property (weak, nonatomic) id<GIFAnchorHandleDelegate>delegate;

@end
