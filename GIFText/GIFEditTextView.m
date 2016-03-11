//
//  GIFEditTextView.m
//  GIFTextView
//
//  Created by Eric Young on 1/20/16.
//  Copyright © 2016 Eric Young. All rights reserved.
//

#import "GIFEditTextView.h"
#import "GIFLabel.h"
#import "GIFAnchorHandle.h"
#import "GIFDeleteHandle.h"

#define HANDLE_SIZE 20

@interface GIFEditTextView () <GIFAnchorHandleDelegate, GIFDeleteHandleDelegate>
@property (strong, nonatomic) GIFLabel *textView;
@property (strong, nonatomic) GIFAnchorHandle *scaleHandle;
@property (strong, nonatomic) GIFDeleteHandle *deleteHandle;
@property (strong, nonatomic) UIView *bgView;
@property (assign, nonatomic) BOOL beganTouch;
@property (strong, nonatomic) NSMutableAttributedString *attrText;
@property (strong, nonatomic) UIColor *textColor;
@end

@implementation GIFEditTextView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //self.backgroundColor = [UIColor greenColor];
        
        self.bgView = [[UIView alloc] init];
        
        self.bgView.translatesAutoresizingMaskIntoConstraints = NO;
        //self.bgView.backgroundColor = [UIColor yellowColor];
        
        [self addSubview:self.bgView];
        
        [self addConstraint:[NSLayoutConstraint
                             constraintWithItem:self.bgView
                             attribute:NSLayoutAttributeLeft
                             relatedBy:NSLayoutRelationEqual
                             toItem:self
                             attribute:NSLayoutAttributeLeft
                             multiplier:1.0
                             constant:10.0]];
        
        [self addConstraint:[NSLayoutConstraint
                             constraintWithItem:self.bgView
                             attribute:NSLayoutAttributeRight
                             relatedBy:NSLayoutRelationEqual
                             toItem:self
                             attribute:NSLayoutAttributeRight
                             multiplier:1.0
                             constant:-10.0]];
        
        [self addConstraint:[NSLayoutConstraint
                             constraintWithItem:self.bgView
                             attribute:NSLayoutAttributeTop
                             relatedBy:NSLayoutRelationEqual
                             toItem:self
                             attribute:NSLayoutAttributeTop
                             multiplier:1.0
                             constant:10.0]];
        
        [self addConstraint:[NSLayoutConstraint
                             constraintWithItem:self.bgView
                             attribute:NSLayoutAttributeBottom
                             relatedBy:NSLayoutRelationEqual
                             toItem:self
                             attribute:NSLayoutAttributeBottom
                             multiplier:1.0
                             constant:-10.0]];
    
        self.textView = [[GIFLabel alloc] init];
        self.textView.adjustsFontSizeToFitWidth = YES;
        self.textView.lineBreakMode = NSLineBreakByWordWrapping;
        self.textView.numberOfLines =1;
        self.textView.textAlignment = NSTextAlignmentCenter;
        self.textView.userInteractionEnabled = YES;
        self.textView.translatesAutoresizingMaskIntoConstraints = NO;
       
        [self.bgView addSubview:self.textView];
        
        [self addConstraint:[NSLayoutConstraint
                             constraintWithItem:self.textView
                             attribute:NSLayoutAttributeLeft
                             relatedBy:NSLayoutRelationEqual
                             toItem:self.bgView
                             attribute:NSLayoutAttributeLeft
                             multiplier:1.0
                             constant:10.0]];
        
        [self addConstraint:[NSLayoutConstraint
                             constraintWithItem:self.textView
                             attribute:NSLayoutAttributeRight
                             relatedBy:NSLayoutRelationEqual
                             toItem:self.bgView
                             attribute:NSLayoutAttributeRight
                             multiplier:1.0
                             constant:-10.0]];
        
        [self addConstraint:[NSLayoutConstraint
                             constraintWithItem:self.textView
                             attribute:NSLayoutAttributeTop
                             relatedBy:NSLayoutRelationEqual
                             toItem:self.bgView
                             attribute:NSLayoutAttributeTop
                             multiplier:1.0
                             constant:0.0]];
        
        [self addConstraint:[NSLayoutConstraint
                             constraintWithItem:self.textView
                             attribute:NSLayoutAttributeBottom
                             relatedBy:NSLayoutRelationEqual
                             toItem:self.bgView
                             attribute:NSLayoutAttributeBottom
                             multiplier:1.0
                             constant:0.0]];
        
        self.scaleHandle = [[GIFAnchorHandle alloc] init];
        self.scaleHandle.backgroundColor = [UIColor blueColor];
        self.scaleHandle.delegate = self;
        self.scaleHandle.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:self.scaleHandle];
        
        [self addConstraint:[NSLayoutConstraint
                             constraintWithItem:self.scaleHandle
                             attribute:NSLayoutAttributeRight
                             relatedBy:NSLayoutRelationEqual
                             toItem:self
                             attribute:NSLayoutAttributeRight
                             multiplier:1.0
                             constant:0.0]];
        
        [self addConstraint:[NSLayoutConstraint
                             constraintWithItem:self.scaleHandle
                             attribute:NSLayoutAttributeBottom
                             relatedBy:NSLayoutRelationEqual
                             toItem:self
                             attribute:NSLayoutAttributeBottom
                             multiplier:1.0
                             constant:0.0]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.scaleHandle
                                                         attribute:NSLayoutAttributeHeight
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:nil
                                                         attribute:NSLayoutAttributeHeight
                                                        multiplier:1.0
                                                          constant:HANDLE_SIZE]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.scaleHandle
                                                         attribute:NSLayoutAttributeWidth
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:nil
                                                         attribute:NSLayoutAttributeHeight
                                                        multiplier:1.0
                                                          constant:HANDLE_SIZE]];
        
        
        self.deleteHandle = [[GIFDeleteHandle alloc] init];
        self.deleteHandle.backgroundColor = [UIColor blueColor];
        self.deleteHandle.delegate = self;
        self.deleteHandle.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:self.deleteHandle];
        
        [self addConstraint:[NSLayoutConstraint
                             constraintWithItem:self.deleteHandle
                             attribute:NSLayoutAttributeLeft
                             relatedBy:NSLayoutRelationEqual
                             toItem:self
                             attribute:NSLayoutAttributeLeft
                             multiplier:1.0
                             constant:0.0]];
        
        [self addConstraint:[NSLayoutConstraint
                             constraintWithItem:self.deleteHandle
                             attribute:NSLayoutAttributeTop
                             relatedBy:NSLayoutRelationEqual
                             toItem:self
                             attribute:NSLayoutAttributeTop
                             multiplier:1.0
                             constant:0.0]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.deleteHandle
                                                         attribute:NSLayoutAttributeHeight
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:nil
                                                         attribute:NSLayoutAttributeHeight
                                                        multiplier:1.0
                                                          constant:HANDLE_SIZE]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.deleteHandle
                                                         attribute:NSLayoutAttributeWidth
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:nil
                                                         attribute:NSLayoutAttributeHeight
                                                        multiplier:1.0
                                                          constant:HANDLE_SIZE]];
        
        
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(editTap:)];
        tapRecognizer.numberOfTapsRequired = 1;
        [self.textView addGestureRecognizer:tapRecognizer];
        
        [self makeEditable:YES animated:YES];
        
    }
    return self;
}

-(void)editTap:(id)sender
{
    [self.delegate wantsToEditTextView:self];
}

-(void)makeEditable:(BOOL)editable animated:(BOOL)animated
{
    CALayer * l1 = [self.bgView layer];
    [l1 setMasksToBounds:YES];
    [l1 setCornerRadius:5.0];
    [l1 setBorderWidth:2.0];
    
    if (editable) {
        if (animated) {
            self.deleteHandle.alpha = 0;
            self.scaleHandle.alpha = 0;
            self.deleteHandle.hidden = NO;
            self.scaleHandle.hidden =NO;
            [UIView animateWithDuration:0.1 animations:^{
                self.deleteHandle.alpha = 1;
                self.scaleHandle.alpha = 1;
            }];
        } else {
            self.deleteHandle.hidden = NO;
            self.scaleHandle.hidden =NO;
        }
        [l1 setBorderColor:[[UIColor darkGrayColor] CGColor]];
        self.isSelected = YES;
    } else {
        if (animated) {
            self.deleteHandle.alpha = 1;
            self.scaleHandle.alpha = 1;
            [UIView animateWithDuration:0.1 animations:^{
                self.deleteHandle.alpha = 0;
                self.scaleHandle.alpha = 0;
            } completion: ^(BOOL finished) {
                self.deleteHandle.hidden = finished;
                self.scaleHandle.hidden = finished;
            }];
        } else {
            self.deleteHandle.hidden = YES;
            self.scaleHandle.hidden =YES;
        }
        
        [l1 setBorderColor:[[UIColor clearColor] CGColor]];
        self.isSelected = NO;
    }
}

-(void)setText:(NSString *)text
{
    _text = text;
    [self.textView setText:text];
    
    [self.textView sizeFontToFit:text minSize:8.0 maxSize:50];
    
    //[self.attrText.mutableString setString:text];
    //self.textView.attributedText = self.attrText;
    
    //[self scaleView:CGPointMake(0, 0)];
    //self.currentFontSize = self.textView.font.pointSize;
    //[self.textView scaleLabel:point];
    
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *t = [touches anyObject];
    CGPoint location = [t locationInView:self];
    [self moveView:location];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
}

-(void)didDelete
{
    [self.delegate didDeleteTextView:self];
}

-(void)didChangeScaleToPoint:(CGPoint)point
{
    [self scaleView:point];
}

-(void)didEndChange
{
    //[self.textView sizeToFit];
    //[self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.textView.frame.size.width, self.textView.frame.size.height)];
    [self setNeedsLayout];
    self.currentFontSize = self.textView.font.pointSize;
}

-(void)scaleView:(CGPoint)point
{
    [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y,self.frame.size.width + point.x ,self.frame.size.height + point.y)];
    [self.textView scaleLabel:point];
    self.currentFontSize = self.textView.font.pointSize;
    //[self.textView scaleFont:point];
    //[self sizeFontToFit:self.text minSize:5.0 maxSize:400.0];
}

-(void)moveView:(CGPoint)point
{
    [self setFrame:CGRectMake((self.frame.origin.x - self.frame.size.width/2 ) + point.x, (self.frame.origin.y - self.frame.size.height/2) + point.y,self.frame.size.width,self.frame.size.height)];
    //[self setTransform:CGAffineTransformMakeTranslation(point.x, point.y)];
}

-(void)changeFont:(UIFont*)font
{
    //NSMutableAttributedString *attr = [self.textView.attributedText mutableCopy];
    //[attr addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, attr.length)];
    //[self.textView setAttributedText:attr];
    _currentFont = font;
    [self.textView setFont:font];
    [self didEndChange];
}

-(void)changeColor:(UIColor*)color
{
    _textColor = color;
    [self.textView setTextColor:color];
}

-(void)setAnchorPoint:(CGPoint)anchorPoint forView:(UIView *)view
{
    CGPoint newPoint = CGPointMake(view.bounds.size.width * anchorPoint.x,
                                   view.bounds.size.height * anchorPoint.y);
    CGPoint oldPoint = CGPointMake(view.bounds.size.width * view.layer.anchorPoint.x,
                                   view.bounds.size.height * view.layer.anchorPoint.y);
    
    newPoint = CGPointApplyAffineTransform(newPoint, view.transform);
    oldPoint = CGPointApplyAffineTransform(oldPoint, view.transform);
    
    CGPoint position = view.layer.position;
    
    position.x -= oldPoint.x;
    position.x += newPoint.x;
    
    position.y -= oldPoint.y;
    position.y += newPoint.y;
    
    view.layer.position = position;
    view.layer.anchorPoint = anchorPoint;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    //[self didEndChange];
}
*/

@end
