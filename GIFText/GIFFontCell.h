//
//  GIFFontCell.h
//  GIFTextView
//
//  Created by Eric Young on 2/1/16.
//  Copyright © 2016 Eric Young. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GIFFontCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *label;


- (CGSize)intrinsicContentSize;


@end
