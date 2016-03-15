//
//  GIFTagFlowLayout.m
//  Pods
//
//  Created by Eric Young on 3/14/16.
//
//

#import "GIFTagFlowLayout.h"

@interface GIFTagFlowLayout ()
@property (nonatomic, assign) float row1Width;
@property (nonatomic, assign) float row2Width;
@end

@implementation GIFTagFlowLayout

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray *attributesForElementsInRect = [super layoutAttributesForElementsInRect:rect];
    NSMutableArray *newAttributesForElementsInRect = [[NSMutableArray alloc] initWithCapacity:attributesForElementsInRect.count];
    self.row1Width = 0.0;
    self.row2Width = 0.0;
    CGFloat top1Margin = 0.0;
    CGFloat top2Margin = 50.0;
    
    BOOL top = YES;
    
    for (UICollectionViewLayoutAttributes *attributes in attributesForElementsInRect) {
        if (top) {
            NSLog(@"t");
            CGRect newLeftAlignedFrame = attributes.frame;
            newLeftAlignedFrame.origin.y = top1Margin;
            newLeftAlignedFrame .origin.x = self.row1Width;
            NSLog(@"topW----> %f", self.row1Width);
            attributes.frame = newLeftAlignedFrame;
            self.row1Width += attributes.frame.size.width;
            top = NO;
        } else {
            NSLog(@"b");
            CGRect newLeftAlignedFrame = attributes.frame;
            newLeftAlignedFrame.origin.y = top2Margin;
            newLeftAlignedFrame.origin.x = self.row2Width;
             NSLog(@"bottomW----> %f", self.row2Width);
            attributes.frame = newLeftAlignedFrame;
            self.row2Width += attributes.frame.size.width;
            top = YES;
        }
        
        [newAttributesForElementsInRect addObject:attributes];
    }
    return newAttributesForElementsInRect;
}
/*
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray *attributesForElementsInRect = [super layoutAttributesForElementsInRect:rect];
    NSMutableArray *newAttributesForElementsInRect = [[NSMutableArray alloc] initWithCapacity:attributesForElementsInRect.count];
    CGFloat leftMargin = 0.0;
    
    for (UICollectionViewLayoutAttributes *attributes in attributesForElementsInRect) {
        if (attributes.frame.origin.x == self.sectionInset.left) {
            leftMargin = self.sectionInset.left;
        } else {
            CGRect newLeftAlignedFrame = attributes.frame;
            newLeftAlignedFrame.origin.x = leftMargin;
            attributes.frame = newLeftAlignedFrame;
        }
        
        leftMargin += attributes.frame.size.width;
        [newAttributesForElementsInRect addObject:attributes];
    }
    return newAttributesForElementsInRect;
}
 */



@end
