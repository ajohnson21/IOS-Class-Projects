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
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [UIColor clearColor];
        
        dotColor = [UIColor colorWithWhite:0.95 alpha:1.0];
        
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
    
    float dotXY = (self.frame.size.width - 20) / 2;
    
    CGContextAddEllipseInRect(context, CGRectMake(dotXY, dotXY, 20, 20));
    
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
