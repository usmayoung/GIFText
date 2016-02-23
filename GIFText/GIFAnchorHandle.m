//
//  GIFAnchorHandle.m
//  GIFTextView
//
//  Created by Eric Young on 1/20/16.
//  Copyright © 2016 Eric Young. All rights reserved.
//

#import "GIFAnchorHandle.h"

@interface GIFAnchorHandle ()
@property (assign,nonatomic) CGPoint lastPoint;
@end

@implementation GIFAnchorHandle

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touch began anchor");
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *t = [touches anyObject];
    CGPoint location = [t locationInView:self];
    //NSLog(@"touch anchor move x:%f y:%f", self.lastPoint.x, self.lastPoint.y);
    [self.delegate didChangeScaleToPoint:location];

}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.delegate didEndChange];
}
@end
