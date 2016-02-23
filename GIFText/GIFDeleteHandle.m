//
//  GIFDeleteHandle.m
//  GIFTextView
//
//  Created by Eric Young on 1/24/16.
//  Copyright © 2016 Eric Young. All rights reserved.
//

#import "GIFDeleteHandle.h"

@implementation GIFDeleteHandle


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touch began anchor");
    [self.delegate didDelete];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
