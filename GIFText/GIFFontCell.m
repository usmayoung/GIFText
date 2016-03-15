//
//  GIFFontCell.m
//  GIFTextView
//
//  Created by Eric Young on 2/1/16.
//  Copyright © 2016 Eric Young. All rights reserved.
//

#import "GIFFontCell.h"

@implementation GIFFontCell

-(void)awakeFromNib
{
    self.layer.cornerRadius = 4;
    //self.tagNameMaxWidthContraint.constant = [[UIScreen mainScreen] bounds].size.width - (8 * 2 - 8 * 2);
    
    self.tagNameMaxWidthContraint.constant = [[UIScreen mainScreen] bounds].size.width;
    self.backgroundColor = [UIColor colorWithRed:.1 green:.1 blue:.1 alpha:1];
}

@end


/*
static CGSize _extraMargins = {0,0};

@implementation GIFFontCell

- (CGSize)intrinsicContentSize
{
    CGSize size = [self.label intrinsicContentSize];
    
    if (CGSizeEqualToSize(_extraMargins, CGSizeZero))
    {
        // quick and dirty: get extra margins from constraints
        for (NSLayoutConstraint *constraint in self.constraints)
        {
            if (constraint.firstAttribute == NSLayoutAttributeBottom || constraint.firstAttribute == NSLayoutAttributeTop)
            {
                // vertical spacer
                _extraMargins.height += [constraint constant];
            }
            else if (constraint.firstAttribute == NSLayoutAttributeLeading || constraint.firstAttribute == NSLayoutAttributeTrailing)
            {
                // horizontal spacer
                _extraMargins.width += [constraint constant];
            }
        }
    }
    
    // add to intrinsic content size of label
    size.width += _extraMargins.width;
    size.height += _extraMargins.height;
    
    return size;
}


@end
  */
