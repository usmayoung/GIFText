//
//  GIFLabel.m
//  GIFTextView
//
//  Created by Eric Young on 1/20/16.
//  Copyright © 2016 Eric Young. All rights reserved.
//

#import "GIFLabel.h"
#define kMaxFieldHeight 9999

@interface GIFLabel ()
@property (assign, nonatomic) float lastX;
@property (assign, nonatomic) float lastY;
@property (assign, nonatomic) float sizeWidth;
@property (assign, nonatomic) float sizeHeight;
@property (assign, nonatomic) BOOL hasInit;

@property (strong, nonatomic) GIFAnchorHandle *scaleHandle;

@end

@implementation GIFLabel

- (id)init
{
    self = [super init];
    if (self) {
        _borderColor = [UIColor blueColor];
        _borderSize = 0;
        
    }
    
    return self;
}

- (void)drawTextInRect:(CGRect)rect {
    
    CGSize shadowOffset = self.shadowOffset;
    UIColor *textColor = self.textColor;
    
    CGContextRef c = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(c, self.borderSize);
    
    CGContextSetLineJoin(c, kCGLineJoinRound);
    CGContextSetTextDrawingMode(c, kCGTextStroke);
    self.textColor = self.borderColor;
    [super drawTextInRect:rect];
    
    CGContextSetTextDrawingMode(c, kCGTextFill);
    self.textColor = textColor;
    self.shadowOffset = CGSizeMake(0, 0);
    [super drawTextInRect:rect];
    
    self.shadowOffset = shadowOffset;
}


-(void)scaleLabel:(CGPoint)point
{
    self.enlargedSize = CGSizeMake(self.frame.size.width + point.x, self.frame.size.height + point.y);
    [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y,self.frame.size.width + point.x ,self.frame.size.height + point.y)];
    
    //[self sizeFontToFit:self.text minSize:15.0 maxSize:150.0];
   
    
    
}

-(void)moveLabel:(CGPoint)point
{
    [self setFrame:CGRectMake((self.frame.origin.x - self.frame.size.width/2 ) + point.x, (self.frame.origin.y - self.frame.size.height/2) + point.y,self.frame.size.width,self.frame.size.height)];
}

-(BOOL)sizeFontToFit:(NSString*)aString minSize:(float)aMinFontSize maxSize:(float)aMaxFontSize
{
    float fudgeFactor = 16.0;
    float fontSize = aMaxFontSize;
    
    self.font = [self.font fontWithSize:fontSize];
    
    CGSize tallerSize = CGSizeMake(self.frame.size.width-fudgeFactor,kMaxFieldHeight);
    CGSize stringSize = [aString boundingRectWithSize:tallerSize
                                              options:NSStringDrawingUsesLineFragmentOrigin
                                           attributes:@{NSFontAttributeName: self.font}
                                              context:nil].size;
    
    while (stringSize.height >= self.frame.size.height)
    {
        if (fontSize <= aMinFontSize) // it just won't fit
            return NO;
        
        fontSize -= 2.0;
        self.font = [self.font fontWithSize:fontSize];
        tallerSize = CGSizeMake(self.frame.size.width-fudgeFactor,kMaxFieldHeight);
        stringSize = [aString boundingRectWithSize:tallerSize
                                           options:NSStringDrawingUsesLineFragmentOrigin
                                        attributes:@{NSFontAttributeName: self.font}
                                           context:nil].size;
    }
    
    self.font = [self.font fontWithSize:self.font.pointSize - 1.0];
    return YES;
}

/*
- (void)drawTextInRect:(CGRect)rect {
    
    UIColor *borderColor = [UIColor redColor];;
    UIColor *fillColor = self.textColor;
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(context, 5.0f);
    CGContextSetTextDrawingMode(context, kCGTextStroke);
    self.textColor = borderColor;
    [super drawTextInRect:rect];
    
    CGContextSetLineWidth(context, 0.0f);
    CGContextSetTextDrawingMode(context, kCGTextFillStroke);
    self.textColor = fillColor;
    [super drawTextInRect:rect];
}
 */

/*
-(BOOL)sizeFontToFit:(NSString*)aString minSize:(float)aMinFontSize maxSize:(float)aMaxFontSize
{
    float fudgeFactor = 16.0;
    float fontSize = aMaxFontSize;
    
    self.font = [self.font fontWithSize:fontSize];
    
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    //style.lineSpacing = .2;
    self.attributedText = [[NSAttributedString alloc]
                                    initWithString:self.attributedText.string
                                    attributes:@{NSFontAttributeName:self.font, NSParagraphStyleAttributeName : style}];
    
    CGSize tallerSize = CGSizeMake(self.frame.size.width-fudgeFactor,kMaxFieldHeight);
    CGRect textRect = [self.attributedText.string boundingRectWithSize:tallerSize
                                            options:NSStringDrawingUsesLineFragmentOrigin
                                         attributes:@{NSFontAttributeName:self.font, NSParagraphStyleAttributeName : style}
                                            context:nil];
    CGSize stringSize = textRect.size;
    
    while (stringSize.height >= self.frame.size.height)
    {
        if (fontSize <= aMinFontSize) // it just won't fit
            return NO;
        
        fontSize -= 2.0;
        self.font = [self.font fontWithSize:fontSize];
        tallerSize = CGSizeMake(self.frame.size.width-fudgeFactor,kMaxFieldHeight);
        CGRect textRect = [aString boundingRectWithSize:tallerSize
                                                options:NSStringDrawingUsesLineFragmentOrigin
                                             attributes:@{NSFontAttributeName:self.font,
                                                          NSParagraphStyleAttributeName : style}
                                                context:nil];
        stringSize = textRect.size;
        
        
    }
    
    return YES;
}
*/

/*
- (void)drawTextInRect:(CGRect)rect {
    UIEdgeInsets insets = {0, 0, 0, 0};
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, insets)];
}
*/

/*
-(void)drawRect:(CGRect)rect
{
    //self.layer.masksToBounds = YES;
    //self.layer.cornerRadius = 8.0;
}
 */

@end
