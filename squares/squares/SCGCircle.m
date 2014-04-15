//
//  SCGCircle.m
//  squares
//
//  Created by Austen Johnson on 4/11/14.
//  Copyright (c) 2014 Austen Johnson. All rights reserved.
//

#import "SCGCircle.h"

@implementation SCGCircle
{
    UIColor * dotColor;
    float dotWidth;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [UIColor clearColor];
        
        dotColor = [UIColor colorWithWhite:0.95 alpha:1.0];
        dotWidth = frame.size.width / 2;
        
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
 
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [dotColor set];
    
    float dotXY = (self.frame.size.width - dotWidth) / 2;
    
    CGContextAddEllipseInRect(context, CGRectMake(dotXY, dotXY, dotWidth, dotWidth));
    
    CGContextFillPath(context);
    
 
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
   // asks for color from VC while giving position of tapped circle
    dotColor = [self.delegate circleTappedWithgPosition:self.position];
    
    // redraws layer with the -drawRect Method above
    [self setNeedsDisplay];
    
    NSLog(@"my position is col %d, row %d",(int)self.position.x,(int)self.position.y);
}

@end
