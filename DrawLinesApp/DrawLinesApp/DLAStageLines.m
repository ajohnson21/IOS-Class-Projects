//
//  DLAStage.m
//  DrawLinesApp
//
//  Created by Austen Johnson on 4/15/14.
//  Copyright (c) 2014 Austen Johnson. All rights reserved.
//

#import "DLAStageLines.h"

@implementation DLAStageLines
{
    NSMutableArray * lines;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        lines = [@[] mutableCopy];
        
        self.lineWidth = 2.0;
        self.lineColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor blackColor];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [[UIColor blackColor] set];
    
    CGContextSetLineWidth(context, self.lineWidth);
    CGContextSetLineCap(context, kCGLineCapRound);
    
    for (NSDictionary * line in lines)
    {
        CGContextSetLineWidth(context, [line[@"width"] floatValue]);
        
        [(UIColor *) line[@"color"] set];
        
        CGPoint start = [line[@"points"][0] CGPointValue];
        CGPoint end = [line[@"points"][1] CGPointValue];
        
        CGContextMoveToPoint(context, start.x, start.y);
        CGContextAddLineToPoint(context, end.x, end.y);
        CGContextStrokePath(context);
    }
}

-(void)undo
{
    NSLog(@"lines undo");
    [lines removeLastObject];
    [self setNeedsDisplay];
}

-(void)clearStage
{
    NSLog(@"Lines clear");
    [lines removeAllObjects];
    [self setNeedsDisplay];
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{    
    for (UITouch * touch in touches) {
        CGPoint location = [touch locationInView:self];
        [lines addObject:[@{
                            @"color": self.lineColor,
                            @"width": @(self.lineWidth),
                            @"points": [@[
                                          [NSValue valueWithCGPoint:location],
                                          [NSValue valueWithCGPoint:location]
                                          ] mutableCopy]
                            } mutableCopy]];
        
        NSLog(@"Touch X: %f Y %f", location.x,location.y);
        [self setNeedsDisplay];
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch * touch in touches)
    {
        CGPoint location = [touch locationInView:self];
        
        [lines lastObject][@"points"][1] = [NSValue valueWithCGPoint:location];
        
        NSLog(@"Touch X: %f Y %f", location.x,location.y);
        [self setNeedsDisplay];
    }
    
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch * touch in touches)
    {
        CGPoint location = [touch locationInView:self];
        
        [lines lastObject][@"points"][1] = [NSValue valueWithCGPoint:location];
        
        NSLog(@"Touch X: %f Y %f", location.x,location.y);
        [self setNeedsDisplay];
    }
    
}


@end
