//
//  DLAStageScribble.m
//  DrawLinesApp
//
//  Created by Austen Johnson on 4/15/14.
//  Copyright (c) 2014 Austen Johnson. All rights reserved.
//

#import "DLAStageScribble.h"

@implementation DLAStageScribble
{
    NSMutableArray * scribbles;
    

}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.lineWidth = 2.0;
        self.lineColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor blackColor];
        
        scribbles = [@[] mutableCopy];

        
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineWidth(context, self.lineWidth);
    
    [self.lineColor set];

    for (NSDictionary * scribble in scribbles)
    {
        CGContextSetLineWidth(context, [scribble[@"width"] floatValue]);
        
        [(UIColor *) scribble[@"color"] set];
        NSArray * points = scribble[@"points"];
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
    [scribbles removeLastObject];
    [self setNeedsDisplay];
}

-(void)clearStage
{
    [scribbles removeAllObjects];
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
        [scribbles addObject:[@{
                                @"color": self.lineColor,
                                @"width": @(self.lineWidth),
                                @"points": [@[[NSValue valueWithCGPoint:location]] mutableCopy]
                                } mutableCopy]];
    }
    [self setNeedsDisplay];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch * touch in touches)
    {
        CGPoint location = [touch locationInView:self];
        [[scribbles lastObject][@"points"] addObject:[NSValue valueWithCGPoint:location]];
    }
    [self setNeedsDisplay];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch * touch in touches)
    {
        CGPoint location = [touch locationInView:self];
        [[scribbles lastObject][@"points"] addObject:[NSValue valueWithCGPoint:location]];
    }
    [self setNeedsDisplay];
}


@end
