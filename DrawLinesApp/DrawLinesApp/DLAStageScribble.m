//
//  DLAStageScribble.m
//  DrawLinesApp
//
//  Created by Austen Johnson on 4/15/14.
//  Copyright (c) 2014 Austen Johnson. All rights reserved.
//

#import "DLAStageScribble.h"

@implementation DLAStageScribble

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.lineWidth = 2.0;
        self.lineColor = [UIColor purpleColor];
        self.backgroundColor = [UIColor whiteColor];
        
        self.lines = [@[] mutableCopy];

        
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineWidth(context, self.lineWidth);
    
//    CGContextAddRect(context, CGRectMake(50, 50, 50, 50));
    
//    [[UIColor blueColor] set];
//    
//    CGContextAddEllipseInRect(context, CGRectMake(80, 200, 90, 50));
//    
//    
//    CGContextFillPath(context);
//    
//    CGContextAddEllipseInRect(context, CGRectMake(80, 200, 90, 50));
//    
//    [[UIColor redColor] set];
//
//    
//    CGContextStrokePath(context);
//    
//    
//    [[UIColor redColor] set];
//
//    
//    CGContextFillEllipseInRect(context, CGRectMake(160, 200, 90, 50));
    
    
//    CGContextSetFont(context, );
    
//    CGContextMoveToPoint(context, 50, 50);
//    CGContextAddCurveToPoint(context, 270, 50, 270, 400, 50, 400);
    
    [self.lineColor set];

    for (NSDictionary * line in self.lines)
    {
        CGContextSetLineWidth(context, [line[@"width"] floatValue]);
        
        [(UIColor *) line[@"color"] set];
        NSArray * points = line[@"points"];
        CGPoint start = [points[0] CGPointValue];
        CGContextMoveToPoint(context, start.x, start.y);
        for (NSValue * value in points)
        {
            CGPoint point = [value CGPointValue];
         CGContextAddLineToPoint(context, point.x, point.y);
        }
        CGContextStrokePath(context);
    }
}

-(void)undo
{
    [self.lines removeLastObject];
    [self setNeedsDisplay];
}

-(void)clearStage
{
    [self.lines removeAllObjects];
    [self setNeedsDisplay];
}

-(void)setLineWidth:(float)lineWidth
{
    _lineWidth = lineWidth;
    [self setNeedsDisplay];
}


-(void)setLineColor:(UIColor *)lineColor
{
    _lineColor = lineColor;
    [self setNeedsDisplay];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch * touch in touches) {
        CGPoint location = [touch locationInView:self];
        [self.lines addObject:[@{
                                @"color": self.lineColor,
                                @"width": @(self.lineWidth),
                                @"points": [@[[NSValue valueWithCGPoint:location]] mutableCopy]
                                } mutableCopy]];
    }
    [self setNeedsDisplay];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self doTouch:touches];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self doTouch:touches];
}


-(void)doTouch:(NSSet *)touches
{
    UITouch * touch = [touches allObjects][0];
    CGPoint location = [touch locationInView:self];
    [[self.lines lastObject][@"points"] addObject:[NSValue valueWithCGPoint:location]];
    [self setNeedsDisplay];
    
}

@end
