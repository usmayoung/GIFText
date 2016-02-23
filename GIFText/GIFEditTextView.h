//
//  GIFEditTextView.h
//  GIFTextView
//
//  Created by Eric Young on 1/20/16.
//  Copyright © 2016 Eric Young. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GIFEditTextView;

@protocol GIFEditTextViewDelegate <NSObject>
-(void)didDeleteTextView:(GIFEditTextView*)textView;
-(void)wantsToEditTextView:(GIFEditTextView*)textView;
@end

@interface GIFEditTextView : UIView

@property (nonatomic, strong) NSString* text;
@property (nonatomic, strong) UIFont *currentFont;
@property (nonatomic, assign) float currentFontSize;
@property (nonatomic, assign) BOOL isSelected;
@property (weak, nonatomic) id<GIFEditTextViewDelegate>delegate;

-(void)changeFont:(UIFont*)font;
-(void)changeColor:(UIColor*)color;
-(void)makeEditable:(BOOL)editable animated:(BOOL)animated;

@end
