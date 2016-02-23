//
//  GIFLabel.h
//  GIFTextView
//
//  Created by Eric Young on 1/20/16.
//  Copyright © 2016 Eric Young. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GIFAnchorHandle.h"

#import "ARLabel.h"

@interface GIFLabel : ARLabel
@property (nonatomic, retain) UIColor* borderColor;
@property (nonatomic) int borderSize;

-(instancetype)init;
-(BOOL)sizeFontToFit:(NSString*)aString minSize:(float)aMinFontSize maxSize:(float)aMaxFontSize;
-(void)scaleLabel:(CGPoint)point;


@end
